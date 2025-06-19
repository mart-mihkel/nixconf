let
  pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOaFDA3Pnwq88+eeD2wJrg0MCabc87+EYuCkNFX5EshL";
in {
  services.soft-serve = {
    enable = true;
    settings.initial_admin_keys = [pubkey];
  };

  networking.firewall.allowedTCPPorts = [23231];
}
