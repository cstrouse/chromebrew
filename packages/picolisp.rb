require 'package'

class Picolisp < Package
  description 'PicoLisp is a lightweight lisp focused on simplicity and minimalism.'
  homepage 'https://picolisp.com/wiki/?home'
  version '19.6'
  source_url 'https://software-lab.de/picoLisp-19.6.tgz'
  source_sha256 'f8114047a860334e9a0903ce9bec86509e1dd90569b98189c21cd257aaa1bdc7'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    Dir.chdir 'src' do
      case ARCH
      when 'x86_64', 'i686'
        puts 'not supported yet'
      when 'armv7l', 'aarch64' # if they release aarch64 hw w/ 64-bit userland this will change
        system 'make DYNAMIC-CC-FLAGS=-fPIC M32='
        system 'make tools gate'
      end
    end
  end

  def self.install
    Dir.chdir 'src' do
      case ARCH
      when 'x86_64', 'i686'
        puts 'not supported yet'
      when 'armv7l', 'aarch64'
        FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/picolisp"
        system "cp -rf ../* #{CREW_DEST_LIB_PREFIX}/picolisp/"
        system "cp ../man/man1/{pil,picolisp}.1 #{CREW_DEST_PREFIX}/share/man/man1/"
        system "rm -rf #{CREW_DEST_LIB_PREFIX}/picolisp/{src,man,java,ersatz}"
        # sed -i "1 s|^.*$|#!/usr/local/bin/picolisp /usr/local/lib/picolisp/lib.l|g" #{CREW_DEST_LIB_PREFIX}/picolisp/bin/{pil,vip,pilIndent,pilPretty}
        # ln -s #{CREW_DEST_LIB_PREFXIX}/picolisp/bin/{picolisp,pil,vip,pilIndent,pilPretty,httpGate} /usr/local/bin/
      end
  end
end
