# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
	unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
	i3statusbarconfig = pkgs.writeText "i3statusbar-config" ''
		theme = "solarized-dark"
		icons = "awesome"
		[[block]]
		block = "battery"
		upower = true
		format = "{percentage}% {time}"
		[[block]]
		block = "focused_window"
		max_width = 21
 
		[[block]]
		block = "backlight"
		[[block]]
		block = "disk_space"
		path = "/d"
		alias = "/d"
		info_type = "available"
		unit = "GB"
		interval = 20
		warning = 20.0
		alert = 10.0
		[[block]]
		block = "disk_space"
		path = "/"
		alias = "/"
		info_type = "available"
		unit = "GB"
		interval = 20
		warning = 20.0
		alert = 10.0
		[[block]]
		block = "memory"
		display_type = "memory"
		format_mem = "{Mug}/{MTg}GB({Mup}%)"
		format_swap = "{SUg}/{STg}GB({SUp}%)"
		icons = true
		clickable = true
		interval = 5
		warning_mem = 80
		warning_swap = 80
		critical_mem = 95
		critical_swap = 95
		[[block]]
		block = "cpu"
		interval = 1
		[[block]]
		block = "load"
		interval = 1
		format = "{1m}"
		[[block]]
		block = "uptime"
		[[block]]
		block = "temperature"
		collapsed = false
		interval = 10
		format = "{min}° min, {max}° max, {average}° avg"
		[[block]]
		block = "sound"
		[[block]]
		block = "time"
		interval = 60
		format = "%a %d/%m %R"
	'';
	swayconfig = pkgs.writeText "swayconfig" ''
		# Logo key. Use Mod1 for Alt.
		set $mod Mod4
		# Home row direction keys, like vim
		set $left h
		set $down j
		set $up k
		set $right l
		# Your preferred terminal emulator
		set $term alacritty
		# Your preferred application launcher
		set $menu dmenu_path | j4-dmenu-desktop --dmenu='bemenu -i --nb "#3f3f3f" --nf "#dcdccc" --fn "pango:DejaVu Sans Mono 12"' --term='alacritty' | xargs swaymsg exec --
		### Output configuration
		# You can get the names of your outputs by running: swaymsg -t get_outputs
		output eDP-1 scale 1
		### Idle configuration
		exec swayidle -w \
					timeout 300 'swaylock -f -c 000000' \
					timeout 600 'swaymsg "output * dpms off"' \
							 resume 'swaymsg "output * dpms on"' \
					before-sleep 'swaylock -f -c 000000'
		# This will lock your screen after 300 seconds of inactivity, then turn off
		# your displays after another 300 seconds, and turn your screens back on when
		# resumed. It will also lock your screen before your computer goes to sleep.
		### Input configuration
		
		# You can get the names of your inputs by running: swaymsg -t get_inputs
		# Read `man 5 sway-input` for more information about this section.
		### Key bindings
		# start a terminal
		bindsym $mod+Return exec $term
		# kill focused window
		bindsym $mod+Shift+q kill
		# start your launcher
		bindsym $mod+d exec $menu
		# Drag floating windows by holding down $mod and left mouse button.
		# Resize them with right mouse button + $mod.
		# Despite the name, also works for non-floating windows.
		# Change normal to inverse to use left mouse button for resizing and right
		# mouse button for dragging.
		floating_modifier $mod normal
		# reload the configuration file
		bindsym $mod+Shift+c reload
		# exit sway (logs you out of your Wayland session)
		bindsym $mod+Shift+e exec swaymsg exit
		bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
		bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
		bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound
		# Brightness
		bindsym XF86MonBrightnessDown exec light -U 5
		bindsym XF86MonBrightnessUp exec light -A 5
		# Printscreen
		bindsym --release Print exec grim -g \"$(slurp)" - | wl-copy
		## Moving around:
		
		# Move your focus around
		bindsym $mod+$left focus left
		bindsym $mod+$down focus down
		bindsym $mod+$up focus up
		bindsym $mod+$right focus right
		# or use $mod+[up|down|left|right]
		bindsym $mod+Left focus left
		bindsym $mod+Down focus down
		bindsym $mod+Up focus up
		bindsym $mod+Right focus right
		# _move_ the focused window with the same, but add Shift
		bindsym $mod+Shift+$left move left
		bindsym $mod+Shift+$down move down
		bindsym $mod+Shift+$up move up
		bindsym $mod+Shift+$right move right
		# ditto, with arrow keys
		bindsym $mod+Shift+Left move left
		bindsym $mod+Shift+Down move down
		bindsym $mod+Shift+Up move up
		bindsym $mod+Shift+Right move right
		## Workspaces:
		# switch to workspace
		bindsym $mod+1 workspace 1
		bindsym $mod+2 workspace 2
		bindsym $mod+3 workspace 3
		bindsym $mod+4 workspace 4
		bindsym $mod+5 workspace 5
		bindsym $mod+6 workspace 6
		bindsym $mod+7 workspace 7
		bindsym $mod+8 workspace 8
		bindsym $mod+9 workspace 9
		bindsym $mod+0 workspace 10
		# move focused container to workspace
		bindsym $mod+Shift+1 move container to workspace 1
		bindsym $mod+Shift+2 move container to workspace 2
		bindsym $mod+Shift+3 move container to workspace 3
		bindsym $mod+Shift+4 move container to workspace 4
		bindsym $mod+Shift+5 move container to workspace 5
		bindsym $mod+Shift+6 move container to workspace 6
		bindsym $mod+Shift+7 move container to workspace 7
		bindsym $mod+Shift+8 move container to workspace 8
		bindsym $mod+Shift+9 move container to workspace 9
		bindsym $mod+Shift+0 move container to workspace 10
		# Note: workspaces can have any name you want, not just numbers.
		# We just use 1-10 as the default.
		## Layout stuff:
		# You can "split" the current object of your focus with
		# $mod+b or $mod+v, for horizontal and vertical splits
		# respectively.
		bindsym $mod+b splith
		bindsym $mod+v splitv
		# Switch the current container between different layout styles
		bindsym $mod+s layout stacking
		bindsym $mod+w layout tabbed
		bindsym $mod+e layout toggle split
		# Make the current focus fullscreen
		bindsym $mod+f fullscreen
		# Toggle the current focus between tiling and floating mode
		bindsym $mod+Shift+space floating toggle
		# Swap focus between the tiling area and the floating area
		bindsym $mod+space focus mode_toggle
		# move focus to the parent container
		bindsym $mod+a focus parent
		## Scratchpad:
		# Sway has a "scratchpad", which is a bag of holding for windows.
		# You can send windows there and get them back later.
		# Move the currently focused window to the scratchpad
		bindsym $mod+Shift+minus move scratchpad
		# Show the next scratchpad window or hide the focused scratchpad window.
		# If there are multiple scratchpad windows, this command cycles through them.
		bindsym $mod+minus scratchpad show
		## Resizing containers:
		mode "resize" {
			# left will shrink the containers width
			# right will grow the containers width
			# up will shrink the containers height
			# down will grow the containers height
			bindsym $left resize shrink width 10px
			bindsym $down resize grow height 10px
			bindsym $up resize shrink height 10px
			bindsym $right resize grow width 10px
			# ditto, with arrow keys
			bindsym Left resize shrink width 10px
			bindsym Down resize grow height 10px
			bindsym Up resize shrink height 10px
			bindsym Right resize grow width 10px
			# return to default mode
			bindsym Return mode "default"
			bindsym Escape mode "default"
		}
		bindsym $mod+r mode "resize"
		## Status Bar:
		# Read `man 5 sway-bar` for more information about this section.
		bar {
			font pango:DejaVu Sans Mono, FontAwesome 12
			position top
			# When the status_command prints a new line to stdout, swaybar updates.
			# The default just shows the current date and time.
			status_command i3status-rs ${i3statusbarconfig}
			colors {
				separator #666666
				background #222222
				statusline #dddddd
				focused_workspace #0088CC #0088CC #ffffff
				active_workspace #333333 #333333 #ffffff
				inactive_workspace #333333 #333333 #888888
				urgent_workspace #2f343a #900000 #ffffff
			}
		}
	'';
in {
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			#./wm/xmonad.nix # xmonad tiling window manager
			./wm/wayland.nix
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

	programs.sway = { 
		enable = false;
		extraSessionCommands = ''
			export SDL_VIDEODRIVER=wayland
			export QT_QPA_PLATFORM=wayland
			export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
			export _JAVA_AWT_WM_NONREPARENTING=1
			export BEMENU_BACKEND=wayland
			export SWAY_CONFIG_DIR=${swayconfig}
		'';
		extraPackages = with pkgs; [
		 swayidle
		 swaylock
		 waybar
		 i3status-rust
		 grim
		 slurp
		 mako
		 wl-clipboard
		 wlstream
		 oguri
		 kanshi
		 redshift-wayland
		 xdg-desktop-portal-wlr
		];
	};

	nixpkgs.overlays = [
		(self: super: {
			wl-clipboard-x11 = super.stdenv.mkDerivation rec {
			pname = "wl-clipboard-x11";
			version = "5";
		
			src = super.fetchFromGitHub {
				owner = "brunelli";
				repo = "wl-clipboard-x11";
				rev = "v${version}";
				sha256 = "1y7jv7rps0sdzmm859wn2l8q4pg2x35smcrm7mbfxn5vrga0bslb";
			};
		
			dontBuild = true;
			dontConfigure = true;
			propagatedBuildInputs = [ super.wl-clipboard ];
			makeFlags = [ "PREFIX=$(out)" ];
			};
		
			xsel = self.wl-clipboard-x11;
			xclip = self.wl-clipboard-x11;
		})
	];

	services.xserver.layout = "gb";

#	xdg.portal.enable = true;
#	systemd.services.upower.enable = true;
#	services = {
#		flatpak.enable = true;
#		picom = {
#			enable = true;
#			fade = true;
#			inactiveOpacity = 1.0;
#			shadow = true;
#			fadeDelta = 4;
#		};
#
#		gnome3.gnome-keyring.enable = true;
#		upower.enable = true;
#
#		xserver = {
#			libinput.enable = true;
#			windowManager.xmonad = {
#				#enable = true;
#				enableContribAndExtras = true;
#			};
#
#			displayManager.defaultSession = "xfce";
#			enable = true;
#			displayManager.lightdm.enable = true;
#			desktopManager.xfce.enable = true;
#			layout = "gb";
#		};
#	};

	# services.xserver.xkbOptions = "eurosign:e";

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound.
	sound.enable = true;

	# Enable touchpad support (enabled default in most desktopManager).


	hardware.opengl.driSupport32Bit = true;
	hardware.opengl.enable = true;

	hardware.pulseaudio = {
		enable = true;
		package = pkgs.pulseaudioFull;
		support32Bit = true;
	};

	programs.fish.enable = true;

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

		mono
		vulkan-tools
		# haskellPackages.haskellPlatform
		
		nerdfonts

		wl-clipboard
		brightnessctl
	
		# general apps & utilities
		firefox
		etcher
		discord
		zoom-us
		pinta
		thunderbird
		agenda
		spotify
		blender
		mupdf
		kdeApplications.kdenlive
		freerdp
		lightworks
		gimp
		virtualbox
		dmenu
		xscreensaver
		webcamoid
		libreoffice
		gparted
		simplescreenrecorder
		jack1 # Audio

		# gaming
		wine
		wineWowPackages.stable
		lutris
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
		nox
		libarchive

		# de
		arc-theme
		plano-theme
		xfce.xfce4-whiskermenu-plugin
		xfce.libxfce4ui
		xfce.thunar
		xfce.xfwm4-themes
		plank
		conky
		haskellPackages.xmobar
		haskellPackages.xmonad
		haskellPackages.xmonad-contrib
		haskellPackages.xmonad-extras
	];

	boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
	nixpkgs.config.allowUnfree = true; # proprietary drivers
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
		comma = import (builtins.fetchTarball "https://github.com/Shopify/comma/archive/master.tar.gz");
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

