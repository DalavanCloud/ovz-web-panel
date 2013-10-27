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

end
