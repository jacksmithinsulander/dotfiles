{

  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      unabomber = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };
   
}
