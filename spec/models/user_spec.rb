require 'spec_helper'

describe "User" do
  fixtures :users, :virtual_servers, :permissions, :roles, :permissions_roles

  it "Admin has superadmin role" do
    admin = users(:admin)
    admin.superadmin?.should_not be_nil
  end

  it "Authenticate user" do
    User.authenticate('admin', 'monkey').should_not be_nil
  end

  it "Fail to authenticate with bad password" do
    User.authenticate('admin', 'badpassword').should be_nil
  end

  it "Fail to authenticate with bad login" do
    User.authenticate('badlogin', 'monkey').should be_nil
  end

  it "Two characters logins are allowed (issue 43)" do
    user = User.new({ :login => 'sp', :password => 'password', :password_confirmation => 'password' })
    user.valid?.should_not be_nil
  end

  it "One character login is not allowed" do
    user = User.new({ :login => 'a', :password => 'password', :password_confirmation => 'password' })
    user.valid?.should_not be_true
  end

  it "Admin removal is not allowed" do
    admin = users(:admin)
    admin.destroy.should_not be_true
  end

  it "User removal is allowed" do
    user = users(:john)
    user.destroy.should_not be_nil
  end

  it "Logins are always in lowercase" do
    user = User.new({ :login => 'CAPS', :password => 'password', :password_confirmation => 'password' })
    user.login.should == "caps"
  end

  it "User can control virtual server" do
    user = users(:john)
    server_101 =  virtual_servers(:server_101)
    server_101.user = user
    user.can_control(server_101).should_not be_nil
  end

  it "User cannot control foreign virtual server" do
    user = users(:john)
    server_101 =  virtual_servers(:server_101)
    user.can_control(server_101).should_not be_true
  end

  it "Admin can control any virtual server" do
    admin = users(:admin)
    server_101 =  virtual_servers(:server_101)
    admin.can_control(server_101).should_not be_nil
  end

  it "User can have email" do
    user = User.new({ :login => 'test', :email => 'root@localhost' })
    user.email.should == "root@localhost"
  end

  it "Email address should be valid" do
    user = User.new({ :login => 'test', :password => 'password', :password_confirmation => 'password', :email => 'not-email' })
    user.valid?.should_not be_true
  end

end
