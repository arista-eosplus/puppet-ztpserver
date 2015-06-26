require 'spec_helper'
describe 'ztpserver' do

  context 'with defaults for all parameters' do
    it { should contain_class('ztpserver') }
    it { should contain_class('ztpserver::source') }
    it { should contain_group('ztpsadmin') }
    it { should contain_user('ztpsadmin') }
    it { should contain_file('/home/ztpsadmin/ztpserver') }
    it { should contain_file('/home/ztpsadmin/src') }
    it { should contain_file('/usr/share/ztpserver') }
  end
end
