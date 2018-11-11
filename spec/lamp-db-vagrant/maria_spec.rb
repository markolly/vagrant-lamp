require 'spec_helper'

if os[:family] == 'ubuntu'

  describe package('mariadb-server-10.1') do
    it { should be_installed }
  end

  describe package('mariadb-client-10.1') do
    it { should be_installed }
  end

  describe service('mysql') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(3306) do
    it { should be_listening }
  end

end
