    { config, pkgs, ...}:

    {
      home.username = "daniel";
      home.homeDirectory = "/home/daniel";
      home.stateVersion = "26.05";

      programs.bash = {
        enable = true;
	shellAliases = {
	  btw = "echo i use nixos btw";
	  nrs = "sudo nixos-rebuild switch";
	};

	initExtra = ''
	  PS1='\[\e[38;5;41m\]\u\[\e[0m\] in \[\e[38;5;39m\]\w\[\e[0m\] \\$ '
	'';
      };
	
      programs.alacritty = {
	enable = true;
	settings = {
	  window.opacity = 0.9;
	  font.normal = {
	    family = "JetBrains Mono";
	    style = "Regular";
	  };
	  font.size = 16;
        };
      };

      home.file.".config/bat/config".text = ''
	--theme="Nord"
	--style="numbers,changes,grid"
	--paging=auto
      '';

      home.file.".config/qtile".source = /home/daniel/nixos-dotfiles/qtile;

      home.packages = with pkgs; [
	bat
      ];
    }

