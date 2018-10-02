let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;
  generator = pkgs.callPackage ../generator {};
in stdenv.mkDerivation rec {
    name = "website";
    src = ./.;
    phases = "unpackPhase buildPhase";
    version = "0.1";
    buildInputs = [ generator ];
    buildPhase = ''
      export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive";
      export LANG=en_US.UTF-8
      generate-site build

      mkdir $out
      cp -r _site/* $out
    '';
  }
