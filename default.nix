{ pkgs ? import <nixpkgs> {}
}:

let
  inherit (pkgs) lib;
  inherit (pkgs) stdenv;

in

stdenv.mkDerivation rec {
  pname = "arbash";
  version = "0.2.0";

  src = ./src;

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildInputs = with pkgs; [
    coreutils
    envsubst
    findutils
    git
    gnugrep
    gnused
    ncurses
    patch
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp arbash $out/bin
    wrapProgram $out/bin/arbash \
      --set VERSION '${version}' \
      --prefix PATH : $coreutils/bin \
      --prefix PATH : $envsubst/bin \
      --prefix PATH : $findutils/bin \
      --prefix PATH : $git/bin \
      --prefix PATH : $gnugrep/bin \
      --prefix PATH : $gnused/bin \
      --prefix PATH : $ncurses/bin \
      --prefix PATH : $patch/bin \
      --argv0 arbash
  '';

  meta = with lib; {
    description = "Text templates manager as After Rain BAmboo SHoots";
    license = licenses.mit;
    maintainers = with maintainers; [ kayhide ];
  };
}
