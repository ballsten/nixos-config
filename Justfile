# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

default: deploy

deploy:
  sudo nixos-rebuild switch --flake .

debug:
  sudo nixos-rebuild switch --flake . --show-trace --verbose

up:
  nix flake update

# Update specific input
# usage: just upp home-manager
[positional-arguments]
@upp input:
  nix flake update $1

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

replf:
  nix repl --expr "builtins.getFlake \"$PWD\""

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old
