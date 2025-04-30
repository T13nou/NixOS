with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname    = "occt";
  version  = "14.0.9";

  src = fetchurl {
    url    = "https://www.ocbase.com/download/edition:Personal/os:Linux";
    # Remplacez par le hash réel retourné par `nix-prefetch-url`
    sha256 = "sha256-i221nPvigSZAeu7i5Y2HVyBoaZQsHPIR0qhKaQhknwQ=";
  };

  # On ne veut plus des phases unpack et build
  phases = [ "installPhase" ];

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs       = [ gtk3 xorg.libX11 xorg.libXext xorg.libXmu xorg.libXi lib
GL libGLU icu ];

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 $src $out/bin/OCCT
  '';

  meta = {
    description = "OCCT ${version} – test de stabilité et bench PC (Personal Edi
tion)";
    homepage    = "https://www.ocbase.com/";
    license     = lib.licenses.unfree;
    platforms   = lib.platforms.linux;
  };
}
