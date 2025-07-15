{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "codelia-encrypted";
  version = "0.1";

  src = builtins.fetchFromGitHub {
    owner = "mostlymaxi";
    repo = "private-fonts";
    rev = "bc6661874c7b4a4d7f3de54740452b492b552f4a";

    hash = "AAAA";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/Codelia/*.otf $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Codelia";
    homepage = "https://tosche.net/fonts/codelia";
    platforms = platforms.all;
  };
}
