require 'spec_helper_acceptance'

describe 'ztpserver class' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'ztpserver': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe 'accounts: ' do
      it 'user ztpsadmin should exist' do
        #shell("mysql -e 'show grants for root@127.0.0.1;'", :acceptable_exit_codes => 1)
        shell("id -a ztpsadin", :acceptable_exit_codes => 1)
      end

      #it 'group ztpsagin should exist' do
      #  shell("mysql -e 'show databases;' |grep test", :acceptable_exit_codes => 1)
      #end
    end
  end
end
