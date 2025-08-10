# Nix dotfiles

### Setup

To bootstrap a system to flakes open a nix-shell with the experimental-features flag:

```bash
nix-shell -p vim -p git --experimental-features 'nix-command flakes'
nixos-rebuild switch --flake .#target-configuration
```

### Home

Dotfiles with home manager:

```bash
nix develop
home-manager switch --flake .#target-home
```

### Secrets

Add the recipient public key from `/etc/ssh` to [secrets/secrets.nix](./secrets/secrets.nix) and reference the relevant secrets

Create secret:

```bash
nix develop
EDITOR=vim agenix -e secret.age
```

Use the secret:

```nix
let
  secret-path = config.age.secrets.secret.path;
in {
  age.secrets.secret.file = ./secrets/secret.age;
}
```
