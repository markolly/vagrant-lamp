require 'spec_helper'

if os[:family] == 'ubuntu'

  describe package('apache2') do
    it { should be_installed }
  end

  describe service('apache2') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe command('curl localhost') do
    its(:stdout) { should contain '<p>This is a test page. Apache with PHP is working!</p>' }
  end

  describe file('/etc/apache2/apache2.conf') do
    it { should be_file }
    it { should contain "ServerTokens Prod" }
    it { should contain "ServerSignature Off" }
  end

end
