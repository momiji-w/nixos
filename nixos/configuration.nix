{ pkgs, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.networkmanager.enable = true;

  services.logind.lidSwitch = "ignore";

  time.timeZone = "Asia/Bangkok";

  # VM
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
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  programs.virt-manager.enable = true;

  security.polkit.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  programs.noisetorch.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Nvidia stuffs
  # services.xserver.videoDrivers = ["nvidia"];
  # hardware = {
  #   opengl.enable = true;
  #   nvidia.modesetting.enable = true;
  #   nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };

  # auto-cpufreq
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
       governor = "powersave";
       turbo = "never";
    };
    charger = {
       governor = "performance";
       turbo = "auto";
    };
  };

  programs.light.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.users.momiji = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "adbusers" "video" "networkmanager" "libvirtd" "wheel" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    neofetch
  ];

  fonts.packages = with pkgs; [
    ubuntu_font_family
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Ubuntu" "Noto Serif Lao" "Noto Serif Thai" ];
      sansSerif = [ "Ubuntu" "Noto Sans Lao" "Noto Sans Thai" ];
      monospace = [ "Ubuntu Mono" ];
    };
  };

  services.kanata = {
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
  services.openssh.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Open ports in the firewall.
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 8000 4444 ];
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

