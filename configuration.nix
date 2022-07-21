{ config, pkgs, ... }:

{
	imports =
	[
		./hardware-configuration.nix
	];

	boot =
	{
		loader =
		{
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		initrd.kernelModules =
		[
			"amdgpu"
		];
	};

	networking =
	{
		useDHCP = false;
		hostName = "Lenovo";
		firewall.enable = true;
		networkmanager.enable = true;
		interfaces.wlp1s0.useDHCP = true;
		nameservers = 
		[ 
			"1.1.1.1" 
			"1.0.0.1" 
		];
	};

	time.timeZone = "America/Sao_Paulo";

	i18n.defaultLocale = "pt_BR.UTF-8";

	console =
	{
		font = "ter-v22b";
		keyMap = "br-abnt2";
	};

	sound.enable = true;

	users.users.pedroigor =
	{
		extraGroups =
		[
			"wheel"
			"networkmanager"
		];
		isNormalUser = true;
		description = "Pedro Igor";
	};

	services =
	{
		xserver =
		{
			layout = "br";
			enable = true;
			videoDrivers =
			[
				"amdgpu"
			];
			desktopManager =
			{
				plasma5.enable = true;
			};
			displayManager =
			{
				sddm =
				{
					enable = true;
					autoNumlock = true;
				};
			};
		};
		pipewire =
		{
			enable = true;
			pulse.enable = true;
		};
		fwupd.enable = true;
		printing.enable = true;
		power-profiles-daemon.enable = true;
	};

	system =
	{
		stateVersion = "unstable";
		autoUpgrade.enable = true;
	};

	environment.systemPackages = with pkgs; with libsForQt5;
	[
		ark
		git
		mpv
		gcc
		ccls
		kate
		nanorc
		kwrited
		firefox
		ktorrent
		cppcheck
		linuxquota
		kde-gtk-config
		aspellDicts.pt_BR
	];

	hardware =
	{
		opengl =
		{
			driSupport = true;
			extraPackages = with pkgs;
			[
				rocm-opencl-icd
				rocm-opencl-runtime
			];
		};
		bluetooth.enable = true;
		pulseaudio.enable = false;
	};

	fonts.fonts = with pkgs;
	[
		fira
		fira-code
		fira-code-symbols
	];

	security =
	{
		rtkit.enable = true;
		apparmor.enable = true;
	};

	nix.autoOptimiseStore = true;
}
