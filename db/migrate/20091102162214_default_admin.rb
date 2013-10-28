class DefaultAdmin < ActiveRecord::Migration
  def self.up
    User.disable_callbacks!(:create)
    user = User.new
    user.login = 'admin'
    user.password = 'admin'
    user.password_confirmation = 'admin'
    user.save :validate => false
  end

  def self.down
    user = User.find_by_login('admin')
    user.destroy
  end
end
