{
  description = "Dev shell wish meson build system for C";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    esp-idf.url = "github:mirrexagon/nixpkgs-esp-dev/";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        # inputs.agenix-shell.flakeModules.default
        inputs.devenv.flakeModule
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
        devenv.shells.default = {
          # packages = with pkgs; [
          # ];
          packages = with pkgs; [
            esp32c3-idf
            espflash
          ];
        };
      };
    };
}
