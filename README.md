# Nix Config

## Setup

```bash
nix-shell -p vim -p git --experimental-features 'nix-command flakes'
nixos-rebuild switch --flake .#<configuration>
```

## Secrets

```bash
# add recipient public key to secrets.nix, then
nix-shell -p ragenix
agenix -e <secret>.age
```

```nix
{config, ...}: {
  age.secrets.<secret>.file = ./secrets/<secret>.age;
  service.secret-file = config.age.secrets.<secret>.path;
}
```

## Dev Shells

```bash
cd ./flakes/<flake>
nix develop
```
