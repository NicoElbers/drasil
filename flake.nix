{
  description = "Zig dev environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.zig = {
    url = "github:mitchellh/zig-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.zls = {
    url = "github:zigtools/zls";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, flake-utils, zls, zig, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        zls_bound = zls.packages.${system}.zls;
        zig_bound = zig.packages.${system}.master;
      in
      {
        devShells.default = with pkgs; mkShell {
          packages = [
            bashInteractive
            zig_bound
            zls_bound
          ];
        };
      });
}
