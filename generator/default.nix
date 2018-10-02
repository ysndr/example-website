# Lucas' Yale website v. 2017-03-02

# Some code copied and/or modified from
# https://utdemir.com/posts/hakyll-on-nixos.html
{pkgs ? import <nixpkgs>}:
let
  stdenv = pkgs.stdenv;
  generator = stdenv.mkDerivation {
    name = "websiteGenerator";
    src = ./.;
    phases = "unpackPhase buildPhase";
    buildInputs = [
      (pkgs.haskellPackages.ghcWithPackages (p: with p; [ hakyll ]))
    ];
    buildPhase = ''
      mkdir -p $out/bin
      ghc -O2 -dynamic --make site.hs -o $out/bin/generate-site
    '';
  };
in generator
