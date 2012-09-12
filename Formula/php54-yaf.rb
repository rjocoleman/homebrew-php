require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Yaf < AbstractPhpExtension
  homepage 'http://pecl.php.net/package/yaf'
  url 'http://pecl.php.net/get/yaf-2.2.1.tgz'
  sha1 '80954485a41dfd1df32aab486959c190c6d4c905'
  head 'https://svn.php.net/repository/pecl/yaf/trunk/', :using => :svn

  depends_on 'autoconf' => :build
  depends_on 'php54' if build.include?('with-homebrew-php') && !Formula.factory('php54').installed?
  depends_on 'pcre'

  def install
    Dir.chdir "yaf-#{version}" unless build.head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    safe_phpize
    system "./configure", "--prefix=#{prefix}"
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file unless build.include? "without-config-file"
  end
end
