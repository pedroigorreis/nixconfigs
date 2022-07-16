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
		kernelParams =
		[
			"radeon.cik_support=0"
			"amdgpu.cik_support=1"
		];
		initrd.kernelModules =
		[
			"amdgpu"
		];
	};

	networking =
	{
		hostName = "Gigabyte";
		firewall.enable = true;
		networkmanager.enable = true;
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
		isNormalUser = true;
		extraGroups =
		[
			"wheel"
			"networkmanager"
		];
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
				xterm.enable = false;
				pantheon.enable = true;
			};
		};
		pipewire.enable = true;
		printing.enable = true;
	};

	system =
	{
		stateVersion = "22.05";
		autoUpgrade.enable = true;
	};

	environment.systemPackages = with pkgs;
	[
		mpv
		nanorc
		firefox
		transmission-gtk
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
		pulseaudio.enable = true;
	};

	fonts.fonts = with pkgs;
	[
		fira
		fira-code
		fira-code-symbols
	];

	nix.autoOptimiseStore = true;
}
