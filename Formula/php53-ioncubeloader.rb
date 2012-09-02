require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Ioncubeloader < AbstractPhpExtension
  homepage 'http://www.ioncube.com/loaders.php'
  if Hardware.is_64_bit? and not ARGV.build_32_bit?
    url 'http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz'
    md5 '96c44e7c2be2975defc4781e863ca0d5'
    version '4.2.2'
  else
    url 'http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz'
    md5 '03e6f1402495eb84f18b1958d52291a1'
    version '4.0.9'
  end

  depends_on 'autoconf' => :build
  depends_on 'php53' if ARGV.include?('--with-homebrew-php') && !Formula.factory('php53').installed?

  skip_clean :all

  def extension_type; "zend_extension"; end

  def options
    [['--32-bit', 'Build 32-bit only.']]
  end

  def install

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    # dirty hack around AbstractPhpExtension.rb filename assumption
    system('mv', "ioncube_loader_dar_5.3.so", "ioncubeloader.so")
    prefix.install "ioncubeloader.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
