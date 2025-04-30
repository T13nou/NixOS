{ stdenv, fetchurl, autoPatchelfHook
, gtk3, libX11, libXext, libXmu, libXi, libGL, libGLU
}:

stdenv.mkDerivation rec {
  pname = "occt";
  version = "14.0.8";

  src = fetchurl {
    url = "https://www.ocbase.com/download/edition:Personal/os:Linux";
    # SHA256 du binaire OCCT 14.0.8 (à calculer et insérer ici)
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  # Pas de phase de compilation : on installe directement le binaire
  installPhase = ''
    mkdir -p $out/bin
    install -m755 OCCT $out/bin/OCCT
  '';

  buildInputs = [ gtk3 libX11 libXext libXmu libXi libGL libGLU ];

  meta = with stdenv.lib; {
    description = "OCCT (OverClock Checking Tool) – outil de test de stabilité et de monitoring matériel";
    homepage    = "https://www.ocbase.com/";
    license     = licenses.unfree;
    platforms   = platforms.linux;
    # (licence : logiciel gratuit, mais non libre)
  };
}
