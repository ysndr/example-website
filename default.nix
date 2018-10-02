let
  pkgs = import <nixpkgs> {};
  git = pkgs.git;
  stdenv = pkgs.stdenv;
  generator = pkgs.callPackage ./generator {};

  target-url = "https://github.com/ysndr/website";
  target-
in rec {

  website = stdenv.mkDerivation rec {
    name = "website";
    src = ./src;
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
  };


  publish = stdenv.mkDerivation rec {
    inherit website;
    inherit target-url;
    name = "publish";
    version = "0.1";
    buildCommand = ''
      echo "+-------------------------------------------------+"
      echo "\|                                                 \|"
      echo "\|   Not possible to publish with \`nix-build\`.     \|"
      echo "\|       Please run \`nix-shell -A publish\`         \|"
      echo "\|                                                 \|"
      echo "+-------------------------------------------------+"
      exit 1
    '';
    shellHook = ''
      export HOME=$PWD
      echo "Pushing to ${target-url}"
      git clone
    '';
  };



}
