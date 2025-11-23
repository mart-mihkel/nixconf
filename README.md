# Nix Config

## Setup

Bootstrap to flakes

```bash
nix-shell -p vim -p git --experimental-features 'nix-command flakes'
nixos-rebuild switch --flake .#target-configuration
```

## Secrets

Add recipient public key to [secrets.nix](./secrets/secrets.nix)

Create secret:

```bash
nix-shell -p ragenix --command 'EDITOR=vim agenix -e secret.age'
```

Use secret:

```nix
let
  secret-path = config.age.secrets.secret.path;
in {
  age.secrets.secret.file = ./secrets/secret.age;
}
```

## Dev Shells

See [./flakes/](flakes)
