require 'spec_helper'

if os[:family] == 'ubuntu'

  describe package('php-common') do
    it { should be_installed }
  end
  describe package('php-pear') do
    it { should be_installed }
  end
  describe package('php7.2-cli') do
    it { should be_installed }
  end
  describe package('php7.2-common') do
    it { should be_installed }
  end
  describe package('php7.2-curl') do
    it { should be_installed }
  end
  describe package('php7.2-fpm') do
    it { should be_installed }
  end
  describe package('php7.2-gd') do
    it { should be_installed }
  end
  describe package('php7.2-json') do
    it { should be_installed }
  end
  describe package('php7.2-mbstring') do
    it { should be_installed }
  end
  describe package('php7.2-mysql') do
    it { should be_installed }
  end
  describe package('php7.2-opcache') do
    it { should be_installed }
  end
  describe package('php7.2-readline') do
    it { should be_installed }
  end
  describe package('php7.2-xml') do
    it { should be_installed }
  end
  describe command('php -version') do
    its(:stdout) { should contain('PHP 7.2').before('Copyright') }
  end
  describe '[FPM] PHP config parameters' do
    context php_config('display_errors', {:ini => '/etc/php/7.2/fpm/php.ini'}) do
      its(:value) { should eq "" }
    end
    context php_config('error_reporting', {:ini => '/etc/php/7.2/fpm/php.ini'}) do
      its(:value) { should eq 22527 }
    end
    context php_config('default_charset', {:ini => '/etc/php/7.2/fpm/php.ini'}) do
      its(:value) { should eq "UTF-8" }
    end
    context php_config('memory_limit', {:ini => '/etc/php/7.2/fpm/php.ini'}) do
      its(:value) { should eq "256M" }
    end
    context php_config('post_max_size', {:ini => '/etc/php/7.2/fpm/php.ini'}) do
      its(:value) { should eq "32M" }
    end
    context php_config('upload_max_filesize', {:ini => '/etc/php/7.2/fpm/php.ini'}) do
      its(:value) { should eq "32M" }
    end
  end

end
