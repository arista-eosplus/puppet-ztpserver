require 'spec_helper'
describe 'ztpserver::source' do

  context 'with defaults for all parameters' do
    it { should contain_class('ztpserver::source') }
    it { should contain_package('git') }
    it { should contain_vcsrepo('/home/ztpsadmin/src/ztpserver') }
    it { should contain_exec('Python install ztpserver') }
    it { should contain_file('/usr/local/bin/ztps') }
  end
end
