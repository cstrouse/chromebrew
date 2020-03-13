require 'package'

class Gusb < Package
  description 'GUsb is a GObject wrapper for libusb1'
  homepage 'https://www.openhub.net/p/gusb'
  version '0.3.4'
  source_url 'https://people.freedesktop.org/~hughsient/releases/libgusb-0.3.4.tar.xz'
  source_sha256 '581fd24e12496654b9b2a0732f810b554dfd9212516c18c23586c0cd0b382e04'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk_doc'
  depends_on 'libusb'
  depends_on 'gobject_introspection'
  depends_on 'usbutils'
  depends_on 'vala'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "sed -i s,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,g contrib/generate-version-script.py"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

end
