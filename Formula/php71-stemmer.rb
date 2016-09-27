require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Stemmer < AbstractPhp71Extension
  init
  desc "This stem extension for PHP."
  homepage "https://github.com/hthetiot/php-stemmer"
  url "https://github.com/hthetiot/php-stemmer/archive/160e2d6cbb2563ef4f07980f862c33e5b4c041c7.tar.gz"
  version "160e2d6cbb"
  sha256 "45708a8b0c1a4a0dc5b11e4b67fd04133e4f5757be29f3ff0081ed541270d6cb"

  bottle do
    cellar :any_skip_relocation
    sha256 "01b1c7c1083f010c0264901fc226dda88a8b81bb667470690f61bded0471f0ce" => :el_capitan
    sha256 "05a22a49c804338ec0f8bb8412d86cf833667a3797d12bd643c44c829a48b418" => :yosemite
    sha256 "26497e229c0e1a7359d1b75a3dafc1b84953fc087da1b802c83b079c504ecaec" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make", "-C", "libstemmer_c"
    system "make"
    prefix.install "modules/stemmer.so"
    write_config_file if build.with? "config-file"
  end
end
