require 'spec_helper'

describe "VirtualServer" do
  fixtures :virtual_servers

  before do
    @server_101 = virtual_servers(:server_101)
  end

  describe "respect_reserved_ctid" do
    describe "ON" do
      before do
        OWP.config.virtual_servers.stub(:respect_reserved_ctid => true)
      end
      it "should NOT be valid with CTID = 0" do
        @server_101.identity = 0
        @server_101.should_not be_valid
      end
      it "should NOT be valid with CTID = 1" do
        @server_101.identity = 1 
        @server_101.should_not be_valid
      end
      it "should NOT be valid with CTID = 100" do
        @server_101.identity = 100
        @server_101.should_not be_valid
      end
      it "should be valid with CTID = 101" do
        @server_101.identity = 101
        @server_101.should be_valid
      end
    end

    describe "OFF" do
      before do
        OWP.config.virtual_servers.stub(:respect_reserved_ctid => false)
      end
      it "should NOT be valid with CTID = 0" do
        @server_101.identity = 0
        @server_101.should_not be_valid
      end
      it "should be valid with CTID = 1" do
        @server_101.identity = 1 
        @server_101.should be_valid
      end
      it "should be valid with CTID = 100" do
        @server_101.identity = 100
        @server_101.should be_valid
      end
      it "should be valid with CTID = 101" do
        @server_101.identity = 101
        @server_101.should be_valid
      end
    end
  end

end
