{ pkgs, inputs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    sha256 = "1cycc5w4ypcc2y6yi53as38bqaa1xrss0kxsyaf2shi82dvywsdq";
  };
  nixvim = inputs.momiji-nixvim.packages.x86_64-linux.default;
  zen = inputs.zen-browser.packages.x86_64-linux.default;
in
{
  imports = [ # Include the results of the hardware scan.
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

  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "usbcore.autosuspend=-1"
    ];
  };

  home-manager.users.momiji = {
    imports = [ ../../home-manager/home.nix ];
    home.packages = [ nixvim zen ];
  };

  services = {
    logind.lidSwitch = "ignore";
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };

    displayManager = {
      defaultSession = "none+i3";
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

    kanata = {
      enable = true;
      keyboards = {
        "lap".config = ''
          (defsrc
           caps h j k l 
          )
          (defalias
           esctog (tap-hold 100 100 esc (layer-toggle vi))
          )
          (deflayer base
           @esctog h j k l
          )
          (deflayer vi
           XX lft down up rght
          )
        '';
      };
    };

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  programs = {
    light.enable = true;
    fish.enable = true;
    noisetorch.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  time.timeZone = "Asia/Bangkok";

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

  # Open ports in the firewall.
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = false;
      allowedTCPPorts = [ 8000 4444 ];
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

  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
