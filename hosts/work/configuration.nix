# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    sha256 = "1h32x8cyhjnz8jhnijs2xh98xmg1q2rrl9gmlj1l3sd8bjr9v929";
  };
  nixvim = inputs.momiji-nixvim.packages.x86_64-linux.default;
  zen = inputs.zen-browser.packages.x86_64-linux.default;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "CBR-NB010"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Vientiane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "lo_LA";
    LC_IDENTIFICATION = "lo_LA";
    LC_MEASUREMENT = "lo_LA";
    LC_MONETARY = "lo_LA";
    LC_NAME = "lo_LA";
    LC_NUMERIC = "lo_LA";
    LC_PAPER = "lo_LA";
    LC_TELEPHONE = "lo_LA";
    LC_TIME = "lo_LA";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services = {
    # logind.lidSwitch = "ignore";
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    displayManager = {
      defaultSession = "shell";
      ly.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput = { enable = true; };

    seatd = { enable = true; };

    # vial firmware udev rule
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';

    # auto-cpufreq
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    tlp = {
      enable = true;
      settings = {
       START_CHARGE_THRESH_BAT0 = 70;
       STOP_CHARGE_THRESH_BAT0 = 85;
      };
    };

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  programs = {
    dconf.enable = true;
    light.enable = true;
    fish.enable = true;
  };

  # VM
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
  };

  users.users.momiji = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "momiji";
    extraGroups = [
      "users"
      "seat"
      "adbusers"
      "kvm"
      "video"
      "networkmanager"
      "libvirtd"
      "wheel"
      "uinput"
    ];
  };

  home-manager.users.momiji = {
    imports = [ ../../home-manager/home.nix ];
    home.packages = [ nixvim zen ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [ toybox vim ];

  fonts = {
    packages = with pkgs; [
      ubuntu_font_family
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Ubuntu" "Noto Serif Lao" "Noto Serif Thai" ];
        sansSerif = [ "Ubuntu" "Noto Sans Lao" "Noto Sans Thai" ];
        monospace = [ "Ubuntu Mono" ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
