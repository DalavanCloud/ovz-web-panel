class ActiveRecord::Base
  # disable callbacks like after_create, after_update, etc
  # usage:
  #   u = User.first
  #   u.xxx = 'yyy'
  #   User.disable_callbacks! :update
  #   u.save
  def self.disable_callbacks! type
    if Rails.version.to_f >= 3.0
      User.reset_callbacks(type)
    else
      User.send("after_#{type}").clear
    end
  end
end
