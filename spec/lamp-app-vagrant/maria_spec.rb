require 'spec_helper'

if os[:family] == 'ubuntu'

  describe package('mariadb-client-10.1') do
    it { should be_installed }
  end
  
  describe host('192.168.0.43') do
    # ping
    it { should be_reachable }
    # timeout setting (default is 5 seconds)
    it { should be_reachable.with( :port => 3306, :proto => 'tcp', :timeout => 2 ) }
  end


end
