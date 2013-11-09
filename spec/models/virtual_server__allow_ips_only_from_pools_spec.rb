require 'spec_helper'

describe "VirtualServer" do
  fixtures :virtual_servers

  before do
    @server_101 = virtual_servers(:server_101)
  end

  describe "allow_ips_only_from_pools" do
    describe "ON" do
      before do
        OWP.config.virtual_servers.stub(:allow_ips_only_from_pools => true)
      end
      describe "(with pool)" do
        before :all do
          IpPool.delete_all
          IpPool.create! :first_ip => '10.0.0.1', :last_ip => '10.0.0.100'
        end
        it "should be valid with ip from pool" do
          @server_101.ip = '10.0.0.15'
          @server_101.should be_valid
        end
        it "should NOT be valid with ip NOT from pool" do
          @server_101.ip = '10.0.1.15'
          @server_101.should_not be_valid
        end
      end
      describe "(w/o pool)" do
        before :all do
          IpPool.delete_all
        end
        it "should be valid with ip from pool" do
          @server_101.ip = '10.0.0.15'
          @server_101.should be_valid
        end
        it "should be valid with ip NOT from pool" do
          @server_101.ip = '10.0.1.15'
          @server_101.should be_valid
        end
      end
    end
    describe "OFF" do
      before do
        OWP.config.virtual_servers.stub(:allow_ips_only_from_pools => false)
      end
      describe "(with pool)" do
        before :all do
          IpPool.delete_all
          IpPool.create! :first_ip => '10.0.0.1', :last_ip => '10.0.0.100'
        end
        it "should be valid with ip from pool" do
          @server_101.ip = '10.0.0.15'
          @server_101.should be_valid
        end
        it "should be valid with ip NOT from pool" do
          @server_101.ip = '10.0.1.15'
          @server_101.should be_valid
        end
      end
      describe "(w/o pool)" do
        before :all do
          IpPool.delete_all
        end
        it "should be valid with ip from pool" do
          @server_101.ip = '10.0.0.15'
          @server_101.should be_valid
        end
        it "should be valid with ip NOT from pool" do
          @server_101.ip = '10.0.1.15'
          @server_101.should be_valid
        end
      end
    end
  end

end
