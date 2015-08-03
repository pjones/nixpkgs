# This module defines a small NixOS ISO that can be used to manage
# GnuPG master private keys offline in a read-only OS.

{ config, pkgs, ... }:

{
  imports =
    [ ./installation-cd-base.nix
      ../../profiles/minimal.nix
    ];

  # Packages to install on the ISO.
  environment.systemPackages = with pkgs;
    [ gnupg cryptsetup ykpers file gnumake parted libossp_uuid

      # Build Emacs without X.
      (emacs.override {withX = false;})
    ];

  # Make the ISO available as the root device.
  boot.initrd.postDeviceCommands = ''
    sleep 2 # Wait for device entries to show up.
    mkdir /mnt-iso-host
    mount -t ext4 /dev/disk/by-label/ISOHOST /mnt-iso-host
    losetup /dev/loop0 /mnt-iso-host/boot/iso/nixos.iso
    ln -nfs /dev/loop0 /dev/root
  '';

  # Make sure networking is disabled.
  networking.useDHCP = false;
  networking.interfaces = { };
  networking.wireless.enable = false;
  networking.interfaceMonitor.enable = false;
}
