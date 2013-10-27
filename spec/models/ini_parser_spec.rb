require 'spec_helper'

describe "IniParser" do

  before do
    config = <<-EOS
TEMPLATE=/var/lib/vz/template
VE_PRIVATE=/var/lib/vz/private/$VEID
CONFIGFILE="vps.basic"

# line with comments
NEIGHBOUR_DEVS = detect
VZFASTBOOT = "no"
  VE0CPUUNITS=1000
IPV6="no"
    EOS
    @parser = IniParser.new(config)
  end

  it "Read value by key" do
    @parser.get('TEMPLATE').should == '/var/lib/vz/template'
    @parser.get('VE_PRIVATE').should == '/var/lib/vz/private/$VEID'
    @parser.get('CONFIGFILE').should == 'vps.basic'
    @parser.get('NEIGHBOUR_DEVS').should == 'detect'
    @parser.get('VZFASTBOOT').should == 'no'
    @parser.get('IPV6').should == 'no'
    @parser.get('VE0CPUUNITS').to_i.should == 1000
  end

  it "Read non-existent key" do
    @parser.get('NO_KEY').should == nil
  end

end
