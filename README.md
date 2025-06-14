# Nix dotfiles and various devenvs

The thing

## Setup

To bootstrap a system to flakes open a nix-shell with the experimental-features flag

```bash
nix-shell -p vim -p git --experimental-features 'nix-command flakes'
nixos-rebuild switch --flake .#target-configuration
```

## Secrets

Add the recipient public key from `/etc/ssh` to [secrets/secrets.nix](./secrets/secrets.nix) and reference the relevant secrets

Create new secret

```bash
nix shell github:ryantm/agenix
EDITOR=vim agenix -e secret.age
```

Make the secret usable

```nix
{
  age.secrets.secret.file = ./secrets/secret.age;
}

let
  secret-file = config.age.secrets.secret.path;
in {}
```

## Devenvs

Run `nix develop` in the dir with a flake, or `docker compose up` for Docker based envs

See [dev-templates](https://github.com/the-nix-way/dev-templates) repo for dev flake templates
