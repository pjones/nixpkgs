# This module defines a small NixOS ISO that can be used to manage
# GnuPG master private keys offline in a read-only OS.

{ config, pkgs, ... }:

{
  imports =
    [ ./installation-cd-base.nix
      ../../profiles/minimal.nix
    ];

  environment.systemPackages = with pkgs;
    [ gnupg cryptsetup ykpers
    ];

  # Make the ISO available as the root device.
  boot.initrd.postDeviceCommands = ''
    sleep 2 # Wait for device entries to show up.
    mkdir /mnt-iso-host
    mount -t ext4 /dev/disk/by-label/ISOHOST /mnt-iso-host
    losetup /dev/loop0 /mnt-iso-host/boot/iso/nixos.iso
    ln -nfs /dev/loop0 /dev/root
  '';
}
