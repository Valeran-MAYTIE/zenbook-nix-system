{pkgs, ...}:

{
  environment = {
    systemPackages = with pkgs; [
      neovim git wget 
    ];
    variables.EDITOR = "nvim";
  };

  services = {
    xserver = {
      enable = true;
      layout = "fr";
      xkbOptions = "eurosigne:e";

      libinput.enable = true;

      displayManager.sddm.enable = true;
      desktopManager.xterm.enable = true;
    };

    tlp.enable = true;

    blueman.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint pkgs.gutenprintBin ];
    };

  };

  hardware.bluetooth.enable = true;

  nixpkgs.config.pulsaudio = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };
}
