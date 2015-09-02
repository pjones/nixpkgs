{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "xctu-${version}";
  version = "6.2.0";

  src =
    if stdenv.system == "x86_64-linux" then
      fetchurl {
        url = "http://ftp1.digi.com/support/utilities/40002881_A.run";
        sha256 = "15kyys4503jczj93820p6xw9msdhqrzjx3gi91svpph6bh3avnhm";
      }
    else if stdenv.system == "i686-linux" then
      fetchurl {
        url = "http://ftp1.digi.com/support/utilities/40002880_A.run";
        sha256 = "09rrf4myfwsib74zaj8ay7jp194rf44nfssjswafmfs8jk7ngrxh";
      }
    else throw "${name} is not supported on ${stdenv.system}";

  phases = [ "installPhase" ]; # "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${src} $out/bin/foo
    chmod 555 $out/bin/foo
  '';
}
