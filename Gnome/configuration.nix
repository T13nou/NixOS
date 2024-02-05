# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl."vm.max_map_count" = 16777216;

  networking.hostName = "Etienne-Desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.cnijfilter2 ];
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Canon_TS8000";
        location = "Home";
        deviceUri = "ipps://192.168.2.12/";
        model = "canonts8000.ppd";
        ppdOptions = {
          MediaType = "plain";
          CNGrayscale = "True";
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Canon_TS8000";
  };
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.etienne = {
    isNormalUser = true;
    home = "/home/etienne";
    description = "Etienne";
    hashedPassword = "$y$j9T$3zXUGnMuRyP9uxn9LnL7e.$FOb80JwzmeY2tlHjqAGJUb1u7dbmBiSWA/GFHB.hcz7";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  users.users.dina = {
    isNormalUser = true;
    home = "/home/dina";
    description = "Dina";
    hashedPassword = "$y$j9T$kw0n0u/Tu5tNgg97MVb491$zJOunKsWLI6ZJSc8qQxv3AqRaI8G4mNZN9UhSQNgoj.";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  users.users.mateo = {
    isNormalUser = true;
    home = "/home/mateo";
    description = "Mateo";
    hashedPassword = "$y$j9T$QKqC5jbBSNG6Q.61F94id.$IOFxvw5hPLRK3qzc2sARpaOKlqAl7IQOjXbBfB.1bPA";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  users.users.elsa = {
    isNormalUser = true;
    home = "/home/elsa";
    description = "Elsa";
    hashedPassword = "$y$j9T$X19CoBFMn0dzZ1acxxuZm0$N7jlBNi1tBPoV3f7LkZWrKwXlDuvtewzMFRtLtkUW70";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  # Copy user faces and create KDE environment
  system.activationScripts.script.text = ''
    cp /mnt/TrueNAS/IT/Ansible/Users_Faces/icons/etienne /var/lib/AccountsService/icons/etienne && chmod 644 /var/lib/AccountsService/icons/etienne
    cp /mnt/TrueNAS/IT/Ansible/Users_Faces/icons/dina /var/lib/AccountsService/icons/dina && chmod 644 /var/lib/AccountsService/icons/dina
    cp /mnt/TrueNAS/IT/Ansible/Users_Faces/icons/mateo /var/lib/AccountsService/icons/mateo && chmod 644 /var/lib/AccountsService/icons/mateo
    cp /mnt/TrueNAS/IT/Ansible/Users_Faces/icons/elsa /var/lib/AccountsService/icons/elsa && chmod 644 /var/lib/AccountsService/icons/elsa
    cp /mnt/TrueNAS/IT/Ansible/Users_Faces/users/etienne /var/lib/AccountsService/users/etienne && chmod 600 /var/lib/AccountsService/users/etienne
    cp /mnt/TrueNAS/IT/Ansible/Users_Faces/users/dina /var/lib/AccountsService/users/dina && chmod 600 /var/lib/AccountsService/users/dina
    cp /mnt/TrueNAS/IT/Ansible/Users_Faces/users/mateo /var/lib/AccountsService/users/mateo && chmod 600 /var/lib/AccountsService/users/mateo
    cp /mnt/TrueNAS/IT/Ansible/Users_Faces/users/elsa /var/lib/AccountsService/users/elsa && chmod 600 /var/lib/AccountsService/users/elsa
        '';


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ### System & utils
    fish neofetch glxinfo
    ### Dev
    vscode gnome.gnome-boxes
    ### Browsers
    floorp microsoft-edge
    ### KDE
    krita okular kdenlive gwenview spectacle kcalc skanpage
    ### Productivity
    libreoffice-qt hunspellDicts.fr-any hunspellDicts.es-es hunspellDicts.en_US hunspellDicts.en_GB-large zoom-us
    ### Entertainment
    komikku gcompris spotify handbrake whatsapp-for-linux vlc discord
    ### Gaming
    vbam yuzu-mainline
    ### Gnome extensions
    gnomeExtensions.dash-to-dock gnomeExtensions.bing-wallpaper-changer gnomeExtensions.appindicator gnome.gnome-tweaks
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
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
  system.stateVersion = "23.11"; # Did you read the comment?

}
