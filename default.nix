{ pkgs ? import <nixpkgs> {}
}:

let
  inherit (pkgs) lib;
  inherit (pkgs) stdenv;

in

stdenv.mkDerivation {
  pname = "arbash";
  version = "0.1.0";

  src = ./src;

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildInputs = with pkgs; [
    envsubst
    findutils
    git
    gnused
    ncurses
    patch
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp arbash $out/bin
    wrapProgram $out/bin/arbash \
      --prefix PATH : $envsubst/bin \
      --prefix PATH : $findutils/bin \
      --prefix PATH : $git/bin \
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
