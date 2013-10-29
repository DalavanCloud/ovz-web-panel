class AddManageRolesPermission < ActiveRecord::Migration
  def up
    Permission.create :name => 'manage_roles'
    superadmin_role = Role.find_by_name('superadmin')
    superadmin_role.permissions << Permission.find_by_name('manage_roles')
  end

  def down
    Permission.find_by_name('manage_roles').delete
  end
end
