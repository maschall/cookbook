require 'formula'

class Liftoff < Formula
  homepage 'https://github.com/maschall/cookbook'
  url 'https://github.com/maschall/cookbook/releases/download/__VERSION__/Cookbook-__VERSION__.tar.gz'
  sha1 '__SHA__'

  def install
    prefix.install 'defaults', 'templates', 'vendor'
    prefix.install 'lib' => 'rubylib'

    man1.install ['man/cookbook.1']
    man5.install ['man/cookbook.5']

    bin.install 'src/cookbook'
  end

  test do
    system "#{bin}/cookbook", '--version'
  end
end
