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
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp arbash $out/bin
    wrapProgram $out/bin/arbash \
      --prefix PATH : $envsubst/bin
  '';

  meta = with lib; {
    description = "Text templates manager as After Rain BAmboo SHoots";
    license = licenses.mit;
    maintainers = with maintainers; [ kayhide ];
  };
}
