{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "codelia";
  version = "0.1";
  src = ./.;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/fonts/*.otf $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Codelia";
    homepage = "https://tosche.net/fonts/codelia";
    platforms = platforms.all;
  };
}
