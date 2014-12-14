{ stdenv, fetchurl, saneBackends, glib, gtk3
, sqlite, zlib, cairo, gdk_pixbuf, pkgconfig
, colord, vala, udev, itstool, libxml2, intltool
}:

stdenv.mkDerivation rec {
  version-series = "3.15";
  version = "${version-series}.2";
  name = "simple-scan-${version}";

  src = fetchurl {
    url = "http://launchpad.net/simple-scan/${version-series}/${version}/+download/${name}.tar.xz";
    sha256 = "fd0be534b86129717a74592e7c6c685bf28cb2ea207f5ab7bb4600e41193fa58";
  };

  buildInputs = [
    saneBackends glib gtk3 sqlite zlib cairo gdk_pixbuf pkgconfig
    colord vala udev itstool libxml2 intltool
   ];

  meta = {
    homepage = https://launchpad.net/simple-scan/;

    description = ''
      Simple Scan is an easy-to-use application, designed to let users
      connect their scanner and quickly have the image/document in an
      appropriate format.  Simple Scan is basically a frontend for
      SANE - which is the same backend as XSANE uses. This means that
      all existing scanners will work and the interface is well
      tested.
    '';

    license = stdenv.lib.licenses.gpl3;
    maintainers = with stdenv.lib.maintainers; [];
    platforms = with stdenv.lib.platforms; linux;
  };
}
