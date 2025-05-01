# dotfiles

```bash
nix-shell -p vim -p git --experimental-features 'nix-command flakes'
nixos-rebuild switch --flake .#<host>
```

## secrets

```bash
cd secrets
nix run github:ryantm/agenix -- -e <secret>.age
```
