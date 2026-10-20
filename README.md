# nixos-dotfiles

Flake-parts + [import-tree](https://github.com/vic/import-tree) "dendritic" layout:
every `.nix` file under `modules/` auto-registers a slice of config under a named
tag (`flake.modules.nixos.<tag>`), and `modules/hosts/*.nix` just composes the tags
each machine needs.

```
modules/
  flake-parts.nix     # flake-parts boilerplate
  base/                # applies to every host: user, boot, networking, nix settings, fonts, packages
  desktop/             # niri + noctalia + ghostty + gtk + wayland utils (both hosts)
  shell/               # bash, bat (both hosts)
  dev/                 # git, editor/CLI tooling (both hosts)
  software/            # chat/media/browser/citrix apps (both hosts); steam (nixos-btw only)
  hardware/nvidia.nix  # NVIDIA driver + KMS setup — nixos-btw only, NOT pulled in for the laptop
  hardware/fingerprint.nix # ELAN fingerprint driver + fprintd — nixos-laptop only
  hosts/               # nixos-btw.nix, nixos-laptop.nix — pick which tags each host gets
```

`nixpkgs` and `home-manager` both track `nixos-unstable`/unstable on purpose (kept
in sync via `home-manager.inputs.nixpkgs.follows`) — that's what's needed for
`wayland.windowManager.niri`, which isn't in home-manager's stable release branches yet.

`nixos-rebuild switch --flake .#<hostname>` handles the OS and (almost) every app
declaratively. A few things can't be expressed in Nix and need to be done by hand,
once, per machine.

## 0. Before the first rebuild on a new machine

`hosts/<host>/hardware-configuration.nix` isn't in this repo (it's per-machine and
git-ignored on purpose) — generate and force-add it before the flake will evaluate
at all (flakes only see git-tracked files):

```sh
sudo nixos-generate-config --show-hardware-config > hosts/laptop/hardware-configuration.nix
git add -f hosts/laptop/hardware-configuration.nix
```

**NVIDIA note:** `modules/hardware/nvidia.nix` is only composed into `nixos-btw`
(`modules/hosts/nixos-btw.nix`) — the laptop host doesn't import it at all, so
nothing NVIDIA-related gets installed there. The laptop (ASUS Zenbook 14 OLED
UX3402ZA, Intel Iris Xe) gets `intel-media-driver` instead.

## 0a. Laptop install (dual boot with Windows)

The laptop keeps Windows alongside NixOS for now. Its EFI partition is only
260 MB and shared with Windows, so it's mounted at **`/boot/efi`** (not `/boot`) —
`/boot` then lives on the ext4 root and kernels never get copied onto the tiny ESP.
`modules/hosts/nixos-laptop.nix` sets `boot.loader.efi.efiSysMountPoint`
accordingly; the mount point during install has to match.

**In Windows, before booting the USB:**

1. Shrink `C:` in Disk Management → leave the space **unallocated** (don't create a partition).
2. Save the BitLocker recovery key (https://account.microsoft.com/devices/recoverykey) —
   disabling Secure Boot makes Windows ask for it on next boot.
3. Turn off Fast Startup (Control Panel → Power Options → "Choose what the power
   buttons do"), otherwise Windows leaves the disk/NTFS in a hibernated state.
4. BIOS (`F2` at boot): disable Secure Boot. Boot menu for the USB is `Esc`.

**In the NixOS installer:**

```sh
lsblk -f   # ESP = the 260M vfat partition (likely nvme0n1p1) — DO NOT FORMAT IT

# In the unallocated space create: root (ext4, rest of the space) + swap (~16G),
# e.g. with cfdisk /dev/nvme0n1 or GParted on the graphical ISO. Then:
mkfs.ext4 -L nixos /dev/nvme0n1pX
mkswap -L swap /dev/nvme0n1pY && swapon /dev/nvme0n1pY

mount /dev/nvme0n1pX /mnt
mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi          # the existing Windows ESP

nixos-generate-config --root /mnt            # writes /mnt/etc/nixos/hardware-configuration.nix

nix-shell -p git
git clone https://github.com/danielkarcz14/nixos.git /mnt/home/daniel/nixos-dotfiles
cd /mnt/home/daniel/nixos-dotfiles
mkdir -p hosts/laptop
cp /mnt/etc/nixos/hardware-configuration.nix hosts/laptop/
git add -f hosts/laptop/hardware-configuration.nix
```

Citrix can't be fetched automatically (see section 1), so the first install fails
on it — for the install, comment out `citrix-workspace` in
`modules/software/citrix.nix`, then:

```sh
nixos-install --flake .#nixos-laptop          # asks for the root password at the end
nixos-enter --root /mnt -c 'passwd daniel'    # user has no password otherwise → can't log in
reboot
```

After the first boot: `sudo chown -R daniel:users ~/nixos-dotfiles`, check the
display name with `niri msg outputs` (config assumes `eDP-1`), commit the
hardware config, then do section 1 and uncomment Citrix again.

GRUB's `useOSProber` puts Windows into the boot menu automatically. When Windows
goes away later: delete its partitions, grow the NixOS root into the freed space,
and remove `time.hardwareClockInLocalTime` from the laptop host.

## 1. Citrix Workspace

`citrix-workspace` is unfree and Citrix's EULA blocks nixpkgs from fetching it
automatically — the tarball has to be downloaded by hand first.

1. Accept the EULA and download the 64-bit `.tar.gz` from:
   https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html
   — if the pinned version isn't on that page (nixpkgs sometimes pins a
   beta/tech-preview release), try
   https://www.citrix.com/downloads/workspace-app/betas-and-tech-previews/workspace-app-tp-for-linux.html
   instead. (pinned version as of this writing: **26.08.0.153** → filename
   `linuxx64-26.08.0.153.tar.gz`; since `nixpkgs` tracks unstable this drifts
   often — `nixos-rebuild`'s error output always prints the exact
   filename/version and URL it currently expects, so just match that)
2. Add it to the Nix store so the build can find it:
   ```sh
   nix-prefetch-url file://$PWD/linuxx64-<version>.tar.gz
   ```
3. Re-run `nixos-rebuild switch --flake .#<hostname>`.

## 2. Wallpaper image

Declared in `modules/desktop/noctalia.nix` (`wallpaper.default.path`), not shipped
in the repo:

```
~/Pictures/wallpapers/wolf.jpg
```

Put your preferred image there, or point that option at wherever you'd rather
keep it.

## 3. Git identity

`modules/dev/git.nix` only sets `programs.git.enable = true` — no name/email/signing
key is declared, so commits won't work until you set them yourself:

```sh
git config --global user.name "..."
git config --global user.email "..."
```

If you sign commits or push over SSH, your key(s) also need to be placed in
`~/.ssh` manually — keys aren't (and shouldn't be) stored in this repo.

## Note: Noctalia panel/bar layout

Noctalia keeps two separate files: `config.toml` (generated by home-manager from
`programs.noctalia.settings` in `modules/desktop/noctalia.nix` — theme, wallpaper)
and `settings.toml`, which noctalia itself owns and freely rewrites whenever you
customize the bar/panel through its own settings UI. `settings.toml` is
**intentionally not Nix-managed** (symlinking it read-only into the store would
just get clobbered — or get your live edits wiped — on the next rebuild).

To get the same bar/panel layout on another machine, copy
`~/.config/noctalia/settings.toml` over from the machine that has it, by hand.
