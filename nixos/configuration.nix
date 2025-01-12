{ pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
  };

  services = {
    logind.lidSwitch = "ignore";
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput = { enable = true; };

    seatd = { enable = true; };

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
    extraGroups =
      [ "seat" "adbusers" "video" "networkmanager" "libvirtd" "wheel" ];
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
