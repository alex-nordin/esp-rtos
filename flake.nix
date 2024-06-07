{
  description = "Dev shell wish meson build system for C";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nixpkgs-esp-dev.url = "github:mirrexagon/nixpkgs-esp-dev/";
  };

  # perSystem = { system, ... }: {
  #   _module.args.pkgs = import inputs.nixpkgs {
  #     inherit system;
  #     overlays = [
  #       inputs.foo.overlays.default
  #       (final: prev: {
  #         # ... things you need to patch ...
  #       })
  #     ];
  #     config = { };
  #   };
  # };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        # inputs.agenix-shell.flakeModules.default
        # inputs.devenv.flakeModule
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule
      ];
      systems = ["x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        lib,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.nixpkgs-esp-dev.overlays.default
          ];
        };

        devShells.default = pkgs.mkShell {
          # packages = with pkgs; [
          #   # esp-idf-esp32c3
          # ];
          inputsFrom = [
            # config.treefmt.build.devShell
            # self'.devShells.webbed_site
            # inputs'.nixpkgs-esp-dev.esp32c3-idf
            # inputs.esp-idf.devShells.esp32c3-idf
          ];
          # let
          # pkgs = import <nixpkgs> { overlays = [ (import "${esp-dev}/overlay.nix") ]; };
          # in
          nativeBuildInputs = with pkgs; [
            just
            esp-idf-esp32c3
            # inputs'.nixpkgs-esp-dev.esp-idf-esp32c3
            espflash
          ];
        };
      };
    };
}
