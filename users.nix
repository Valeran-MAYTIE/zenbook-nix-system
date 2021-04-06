{ pkgs, ...}:

{
  nix.trustedUsers = ["root" "valeran"];

  users = {
    users.valeran = {
      isNormalUser = true;
      home = "/home/valeran";
      extraGroups = ["wheel" "networkManager" "mysql"];
    };
  };
} 
