require 'spec_helper'

describe "HardwareServer" do
  fixtures :hardware_servers

  it "Disconnect physical server" do
    HardwareServer.find_by_host('rock.lan').should_not be_nil
    server = hardware_servers(:rock)
    server.disconnect
    HardwareServer.find_by_host('rock.lan').should be_nil
  end

end
