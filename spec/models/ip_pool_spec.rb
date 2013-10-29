require 'spec_helper'

describe "IpPool" do
  fixtures :ip_pools

  it "IPv4 simple range" do
    ip_pool = ip_pools(:ip_pool_1)
    ip_pool.should be_valid
  end

  it "Bad IPv4 range" do
    ip_pool = ip_pools(:ip_pool_2)
    ip_pool.last_ip = '192.168.0.1'
    ip_pool.should_not be_valid
  end

  it "Range details" do
    ip_pool = ip_pools(:ip_pool_1)
    10.should == ip_pool.total_ips
    10.should == ip_pool.free_ips
    0.should == ip_pool.used_ips
  end

  it "should set hardware_server_id to NULL if it == 0" do
    ip_pool = IpPool.new(
      :first_ip => '10.0.1.1', 
      :last_ip  => '10.0.1.100',
      :hardware_server_id => 0
    )
    ip_pool.save!
    ip_pool.hardware_server_id.should be_nil
  end

  it "should keep hardware_server_id if it != 0" do
    ip_pool = IpPool.new(
      :first_ip => '10.0.1.1', 
      :last_ip  => '10.0.1.100',
      :hardware_server_id => 11
    )
    ip_pool.save!
    ip_pool.hardware_server_id.should == 11
  end
end
