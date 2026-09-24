# nixos-laptop — manual setup

`nixos-rebuild switch --flake .#nixos-laptop` handles the OS and (almost)
every app. These few things can't be expressed in Nix and need to be done
by hand, once, on the laptop.

## 0. Before the first rebuild

The laptop's real `hosts/laptop/hardware-configuration.nix` isn't in this
repo (it's per-machine and git-ignored on purpose). Generate and force-add
it before the flake will evaluate at all:

```sh
sudo nixos-generate-config --show-hardware-config > hosts/laptop/hardware-configuration.nix
git add -f hosts/laptop/hardware-configuration.nix
```

## 1. Citrix Workspace

`citrix_workspace` is unfree and Citrix's EULA blocks nixpkgs from fetching
it automatically — the tarball has to be downloaded by hand first.

1. Accept the EULA and download the 64-bit `.tar.gz` from:
   https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html
   (currently pinned version: **26.01.0.150** → filename `linuxx64-26.01.0.150.tar.gz`;
   if the flake gets updated later, `nixos-rebuild` will print the exact
   filename/version it now expects)
2. Add it to the Nix store so the build can find it:
   ```sh
   nix-prefetch-url file://$PWD/linuxx64-26.01.0.150.tar.gz
   ```
3. Re-run `nixos-rebuild switch --flake .#nixos-laptop`.

## 2. Wallpaper images

Two different wallpaper paths are referenced and neither image is in the
repo:

| Used by | Path |
|---|---|
| Noctalia (`home.nix`) | `~/Pictures/wallpapers/wolf.jpg` |
| X11/Qtile session (`configuration.nix`) | `~/Downloads/walls/wolf.jpg` |

Put the same (or your preferred) image at both paths, or point the configs
at wherever you'd rather keep it.

## 3. Git identity

`home.nix` only sets `programs.git.enable = true` — no name/email/signing
key is declared, so commits won't work until you set them yourself:

```sh
git config --global user.name "..."
git config --global user.email "..."
```

If you sign commits or push over SSH, your key(s) also need to be placed
in `~/.ssh` manually — keys aren't (and shouldn't be) stored in this repo.

## Optional: restore your Noctalia panel/bar layout

`noctalia-state/settings.toml` is a snapshot of your desktop's Noctalia
settings, but it's **not** wired into `home.nix` — it won't be applied
automatically by a rebuild. If you want the laptop to start with the same
bar/panel layout instead of the defaults declared in `home.nix`, copy it
in by hand after the first rebuild:

```sh
cp noctalia-state/settings.toml ~/.config/noctalia/settings.toml
```

(Note: that snapshot points at a different wallpaper file,
`y4cxvsb8hbk71.png`, than the one `home.nix` declares — swap in whichever
one you actually want.)
