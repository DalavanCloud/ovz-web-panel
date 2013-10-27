require 'spec_helper'

describe "ApplicationHelper" do
  include ApplicationHelper

  it "diskspace limit conversion" do
    get_diskspace_mb("2M").should == 2
    get_diskspace_mb("1024").should == 1
    get_diskspace_mb("2G:2.2G").should == 2252
    get_diskspace_mb("1048576:1153024").should == 1126
    get_diskspace_mb(nil).should == 0
    get_diskspace_mb("0:unlimited").should == 0
  end

  it "ram limit conversion" do
    get_ram_mb("0:512M").should == 512
    get_ram_mb("0:2G").should == 2048
    get_ram_mb("0:1048576k").should == 1024
    get_ram_mb('2560P:2560P').should == 10
    get_ram_mb('0:104857600') # not sure if it's right //zed.should == 409600
    get_ram_mb('0:104857600B').should == 100
    get_ram_mb(nil).should == 0
    get_ram_mb("0:unlimited").should == 0
  end
end

