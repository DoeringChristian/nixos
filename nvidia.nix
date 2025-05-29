{pkgs, ...}: {
  # ----------------------------
  # NVIDIA related configuration
  # ----------------------------

  # Enable NVIDIA drivers for xserver
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    # Enable Graphics
    graphics = {
      enable = true;
    };

    # configure nvidia
    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      open = false;
      powerManagement.enable = true;
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      # nvidiaPersistenced = true;
      prime = {
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
      };
    };
  };
}
