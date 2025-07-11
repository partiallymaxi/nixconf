{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "tabulamore-script";
  version = "0.1";
  src = ./.;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/fonts/*.otf $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Tabulamore Script";
    homepage = "https://tosche.net/fonts/tabulamore-script";
    platforms = platforms.all;
  };
}
