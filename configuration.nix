{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./users.nix
      ./packages.nix
      ./fonts.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    cleanTmpDir = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    permitRootLogin = "no";
    passwordAuthentication = true;
  };

  programs.ssh.forwardX11 = true;
  programs.ssh.setXAuthLocation = true;

  networking = {
    hostName = "Valeran-PC";
    networkmanager.enable = true;
    firewall = {
      allowPing = true;
      allowedTCPPorts = [25565 22];
      allowedUDPPorts = [2000];
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  nixpkgs.overlays = [ (import ./overlays/packages.nix) ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "20.09";

}

