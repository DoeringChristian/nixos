{pkgs, ...}: {
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # NixLD for external programms
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
      pkgs.libGL
    ];
  };

  # Fish Shell
  programs.fish = {
    enable = true;
    # To fix error at startup of fish
    vendor.config.enable = true;
    vendor.completions.enable = true;
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "doeringc";
    dataDir = "/home/doeringc"; # default location for new folders
    configDir = "/home/doeringc/.config/syncthing";
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
}
