{
  users.users = {
    kubujuss = {
      createHome = true;
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
    };
  };

  security.sudo.wheelNeedsPassword = false;
}
