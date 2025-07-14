{
  stdenvNoCC,
  lib,
  pkgs,
  config,
}:
stdenvNoCC.mkDerivation {
  pname = "codelia-encrypted";
  version = "0.1";
  # src = config.age.secrets.codelia.path;
  src = ./.;

  dontUnpack = true;

  buildInputs = with pkgs; [
    unzip
  ];

  buildPhase = ''

  '';

  installPhase = ''
    unzip fonts.zip
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/fonts/*.otf $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Codelia";
    homepage = "https://tosche.net/fonts/codelia";
    platforms = platforms.all;
  };
}
