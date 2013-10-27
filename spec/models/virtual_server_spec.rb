require 'spec_helper'

describe "VirtualServer" do
  fixtures :virtual_servers

  before do
    @server_101 =  virtual_servers(:server_101)
  end

  it "IPv6 address assignment" do
    @server_101.ip_address = "2001:0db8:85a3:0000:0000:8a2e:0370:7334"
    @server_101.should be_valid

    @server_101.ip_address = "2001:db8:85a3:0:0:8a2e:370:7334"
    @server_101.should be_valid

    @server_101.ip_address = "2001:db8:85a3::8a2e:370:7334"
    @server_101.should be_valid

    @server_101.ip_address = "2001:db8:85a3::8a2e:370:7334 192.168.100.101"
    @server_101.should be_valid

    @server_101.ip_address = "2001:db8:85a3::8a2e:370:7334 2001:0db8:85a3:0000:0000:8a2e:0370:7301"
    @server_101.should be_valid
  end

  it "IPv4 address assignment" do
    @server_101.ip_address = "192.168.100.1"
    @server_101.should be_valid

    @server_101.ip_address = "192.168.100.1 192.168.100.2"
    @server_101.should be_valid
  end

  it "IPv4 address with netmask" do
    @server_101.ip_address = "10.0.0.1/16"
    @server_101.should be_valid
  end

  it "Incorrect IP address assignment" do
    @server_101.ip_address = "not IP address"
    @server_101.should_not be_valid

    @server_101.ip_address = "192.168.100"
    @server_101.should_not be_valid
  end

  it "IPv4 nameserver assigment" do
    @server_101.nameserver = "192.168.0.254"
    @server_101.should be_valid

    @server_101.nameserver = "192.168.100.254 192.168.101.254"
    @server_101.should be_valid
  end

  it "IPv6 nameserver assigment" do
    @server_101.nameserver = "2001:db8:85a3::8a2e:370:7334"
    @server_101.should be_valid

    @server_101.nameserver = "2001:db8:85a3::8a2e:370:7334 192.168.100.254"
    @server_101.should be_valid
  end

  it "Incorrect IP for nameserver assignment" do
    @server_101.nameserver = "not IP address"
    @server_101.should_not be_valid

    @server_101.nameserver = "192.168.100"
    @server_101.should_not be_valid
  end

end
