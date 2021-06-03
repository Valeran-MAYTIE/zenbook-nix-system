{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" =
      { device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
      };

    "/boot" =
      { device = "/dev/disk/by-label/EFI";
        fsType = "vfat";
      };
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/2433e0e0-e90e-4ebc-b6d9-0a04e70fd1b6"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
