# homelab

```bash
nix-shell -p git --experimental-features 'nix-command flakes'
nixos-rebuild switch --flake .#[host]
```
