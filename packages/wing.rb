require 'package'

class Wing < Package
  description 'Wing Personal is a free Python IDE designed for students and hobbyists.'
  homepage 'https://wingware.com/'
  version '7.2.0.1'
  case ARCH
  when 'x86_64'
    source_url 'https://wingware.com/pub/wing-personal/7.2.0.1/wing-personal-7.2.0.1-linux-x64.tar.bz2'
    source_sha256 '75a74725c8f7b8f4b00f5f24a259bfdc7b2ebcd84fa0a68e6ad2664e028ed54b'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wing-7.2.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '144dab3ac72b4f020a74f36e87eca46299939547c63106667be97a748d62b771',
  })

  depends_on 'python27'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,/usr/bin/python,#{CREW_PREFIX}/bin/python,' wing-install.py"
  end

  def self.install
    # The install is interactive, so remember to prefix directories with #{CREW_PREFIX} when prompted.
    system './wing-install.py'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.wingpersonal7"
    system "touch #{CREW_DEST_HOME}/.wingpersonal7/ide.log"
    FileUtils.cp "#{CREW_PREFIX}/bin/wing-personal7.2", "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r "#{CREW_PREFIX}/share/wing-personal7.2", "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/wing-personal7.2/wing-personal", "#{CREW_DEST_PREFIX}/bin/wing"
  end

  def self.postinstall
    puts
    puts "Type 'wing' to get started.".lightblue
    puts
    puts "To completely remove including all preferences, execute the following:".lightblue
    puts "crew remove wing".lightblue
    puts "rm -rf ~/.wingpersonal7".lightblue
    puts
  end
end