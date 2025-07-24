{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    glx-no-stencil = true;
    glx-no-rebind-pixmap = true;
  };
}
