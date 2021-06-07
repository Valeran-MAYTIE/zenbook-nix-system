{pkgs, ...}:

{
  environment = {
    systemPackages = with pkgs; [
      neovim git wget 
    ];
    variables.EDITOR = "nvim";
  };

  imports = [
    ./modules/howdy.nix
    ./modules/ir_toggle.nix
  ];

  services = {

    ir-toggle.enable = true;
    howdy = {
      enable = true;
      device = "/dev/video2";
    };

    xserver = {
      enable = true;
      layout = "fr";
      xkbOptions = "eurosigne:e";

      libinput.enable = true;

      displayManager.lightdm.enable = true;
      desktopManager.plasma5.enable = true;
    };

    tlp.enable = true;

    blueman.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint pkgs.gutenprintBin ];
    };
    mysql = {
      enable = true;
      package = pkgs.mariadb;
      dataDir = "/var/db";
    };
    mysqlBackup = {
      enable = true;
      user = "root";
      databases = [ "foo" ];
    };

    longview.mysqlPasswordFile = "/run/keys/mysql.password";
  };

  hardware.bluetooth.enable = true;

  nixpkgs.config.pulsaudio = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  virtualisation.docker = {
    enable = true;
  };
}
