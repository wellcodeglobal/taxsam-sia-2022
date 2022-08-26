class ChangeRolesResourceIdNullFalse < ActiveRecord::Migration[6.1]
  def change
    change_column :roles, :resource_id, :uuid, null: true
  end
end
