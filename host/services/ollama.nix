{
  services.ollama = {
    enable = true;
    openFirewall = true;
  };

  services.nextjs-ollama-llm-ui = {
    enable = true;
    hostname = "0.0.0.0";
  };

  networking.firewall.allowedTCPPorts = [3000]; # nextjs-ollama
}
