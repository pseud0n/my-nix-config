# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
	unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.useDHCP = false;

	networking.hostName = "nixos"; # Define your hostname.
	networking.networkmanager.enable = true;
	time.timeZone = "Europe/London";

	# The global useDHCP flag is deprecated, therefore explicitly set to false here.
	# Per-interface useDHCP will be mandatory in the future, so this generated config
	# replicates the default behaviour.
	networking.interfaces.eno1.useDHCP = true;

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_GB.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "uk";
	};

#	programs.sway = { 
#		enable = false;
#		extraPackages = with pkgs; [
#		 swayidle
#		 swaylock
#		 waybar
#		 i3status-rust
#		 grim
#		 slurp
#		 mako
#		 wl-clipboard
#		 kanshi
#		 xdg-desktop-portal-wlr
#		];
#	};

#services.xserver.layout = "gb";

	xdg.portal.enable = true;
	systemd.services.upower.enable = true;
	services = {
		flatpak.enable = true;
		picom = {
			enable = true;
			fade = true;
			inactiveOpacity = 1.0;
			shadow = true;
			fadeDelta = 4;
		};

		gnome3.gnome-keyring.enable = true;
		upower.enable = true;

		xserver = {
			libinput.enable = true;

			displayManager.defaultSession = "xfce";
			enable = true;
			displayManager.lightdm.enable = true;
			desktopManager.xfce.enable = true;
			layout = "gb";
		};
	};


	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound.
	sound.enable = true;

	# Enable touchpad support (enabled default in most desktopManager).


	hardware.opengl.driSupport32Bit = true;
	hardware.opengl.driSupport = true;
	hardware.opengl.enable = true;
	hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
	hardware.opengl.setLdLibraryPath = true;

	hardware.pulseaudio = {
		enable = true;
		package = pkgs.pulseaudioFull;
		support32Bit = true;
	};

	programs.fish.enable = true;
	programs.steam.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.alexs = {
		shell = pkgs.fish;
		isNormalUser = true;
		extraGroups = [ "wheel" "video" "networkmanager"]; # Enable ‘sudo’ for the user.
	};

	fonts.fonts = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		liberation_ttf
		fira-code
		fira-code-symbols
		mplus-outline-fonts
		dina-font
		proggyfonts
		(nerdfonts.override { fonts = [ "Hack" ]; })
	];

	environment.pathsToLink = [ "/libexc" ];

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		wayland
		sway
		wl-clipboard
		polkit_gnome

		# editors
		vim 
		neovim
		emacs
		((emacsPackagesNgGen emacs).emacsWithPackages (epkgs: [
			epkgs.vterm
		]))

		# coding/dependencies
		gnumake
		cmake
		git

		gcc10
		clang_11
		boost
		ccls

		flex
		unstable.bison

		stack
		ghc
		haskellPackages.stack
		haskellPackages.ghcid
		haskellPackages.haskell-language-server
		#haskellPackages.stack2nix

		python3
		python38Packages.pygobject3
		python38Packages.pyaml
		python38Packages.bpython

		rustc
		rustup
		cargo
		rustfmt
		rust-analyzer

		mono
		vulkan-tools
		bash-completion
		libxkbcommon
		unstable.meson
		# haskellPackages.haskellPlatform
		
		nerdfonts

		wl-clipboard
		brightnessctl
	
		# general apps & utilities
		firefox
		etcher
		discord
		#zoom-us
		thunderbird
		agenda
		spotify
		blender
		mupdf
		kdeApplications.kdenlive
		gimp
		virtualbox
		xscreensaver
		webcamoid
		libreoffice
		gparted
		simplescreenrecorder
		jack1 # Audio
		alacritty
		dockbarx

		# gaming
		wine
		wineWowPackages.stable
		lutris
		#rpcs3
		#(steam.override { extraPkgs = pkgs: [ bumblebee glxinfo libgdiplus ]; nativeOnly = true; }).run
		steam

		# cl utilities
		fish
		wget
		curl
		xclip
		dmidecode
		pciutils usbutils
		wirelesstools
		networkmanager
		unzip
		libsecret
		neofetch
		pfetch
		ripgrep
		fd
		lf
		flatpak
		nodejs
		hexyl
		lsd
		dragon-drop
		htop
		libarchive
		appimage-run
		bat

		# de
		arc-theme
		plano-theme
		xfce.xfce4-whiskermenu-plugin
		xfce.libxfce4ui
		xfce.thunar
		xfce.xfwm4-themes
		xfce.xfce4-dockbarx-plugin
		conky
#		haskellPackages.xmobar
#		haskellPackages.xmonad
#		haskellPackages.xmonad-contrib
#		haskellPackages.xmonad-extras
	];

	boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
	nixpkgs.config.allowUnfree = true; # proprietary drivers
	#nixpkgs.config.allowBroken = true;
	boot.kernelModules = [ "wl" ]; # set of kernel modules loaded in second stage of boot process
	boot.initrd.kernelModules = [ "kvm-intel" "wl" ]; # list of modules always loaded by the initrd (initial ramdisk)

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#	 enable = true;
	#	 enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	hardware.bluetooth.enable = true;
	services.blueman.enable = true; # If no GUI available

	nixpkgs.config.packageOverrides = pkgs: {
		nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
			inherit pkgs;
		};
		vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
		hardware.opengl = {
			enable = true;
			extraPackages = with pkgs; [
				intel-media-driver # LIBVA_DRIVER_NAME=iHD
				vaapiIntel				 # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
				vaapiVdpau
				libvdpau-va-gl
			];
		};
	};
	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "20.09"; # Did you read the comment? No.

}

