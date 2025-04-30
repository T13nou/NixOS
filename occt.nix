{ stdenv, fetchurl, autoPatchelfHook, gtk3, mesa, xorg }:

stdenv.mkDerivation rec {
  pname = "occt";
  version = "14.0.8";

  src = fetchurl {
    url = "https://www.ocbase.com/download/edition:Personal/os:Linux";
    # SHA256 du binaire OCCT 14.0.8 (édition personnelle) – à obtenir avec nix-prefetch-url
    sha256 = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  dontBuild = true;
  buildInputs = [
    gtk3
    mesa
    xorg.libX11
    xorg.libXrandr
    xorg.libXrender
    xorg.libXi
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/OCCT
    runHook postInstall
  '';

  meta = with stdenv.lib; {
    description = "OCCT Personal Edition ${version} – Outil de test de stabilité et de monitoring PC (gratuit pour usage personnel)";
    license = licenses.unfree;
    homepage = "https://www.ocbase.com/";
    platforms = platforms.linux;
  };
}
