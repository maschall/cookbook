require 'formula'

class Liftoff < Formula
  homepage 'https://github.com/maschall/cookbook'
  url 'https://http://maschall.github.io/cookbook/Cookbook-__VERSION__.tar.gz'
  sha1 '__SHA__'

  def install
    prefix.install 'defaults', 'templates', 'vendor'
    prefix.install 'lib' => 'rubylib'

    bin.install 'src/cookbook'
  end

  test do
    system "#{bin}/cookbook", '--version'
  end
end
