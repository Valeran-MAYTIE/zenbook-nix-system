# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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

  networking = {
    hostName = "Valeran-PC";
    networkmanager.enable = true;
    firewall = {
      allowPing = true;
      allowedTCPPorts = [25565];
      allowedTCPPortRanges = [ {
        from = 1714;
	to = 1764;
      } ];
      allowedUDPPortRanges = [ { 
        from = 1714;
        to = 1764; 
      } ];
    };
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "20.09";

  nixpkgs.overlays = [ (import ./overlays/packages.nix) ];

}

