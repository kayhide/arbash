{ pkgs ? import <nixpkgs> {}
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    entr
    findutils
    gnumake
    shunit2
  ];
}
