{
  services = {
    ollama = {
      enable = true;
      openFirewall = true;
    };
    nextjs-ollama-llm-ui = {
      enable = true;
      hostname = "0.0.0.0";
    };
  };

  networking.firewall.allowedTCPPorts = [3000];
}
