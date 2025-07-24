{pkgs, ...}: let
  cfg = ''
    backend = "glx";
    vSync = true;
    glx-no-stencil = true;
    glx-no-rebind-pixmap = true;
  '';
in {
  home = {
    file.".config/picom/picom.conf".text = cfg;
    packages = with pkgs; [
      picom
    ];
  };
}
