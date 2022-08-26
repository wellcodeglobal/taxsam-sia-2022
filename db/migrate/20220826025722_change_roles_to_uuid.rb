class ChangeRolesToUuid < ActiveRecord::Migration[6.1]
  def change
    add_column :roles, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :roles, :resource_uuid, :uuid, default: "gen_random_uuid()", null: false
        
    change_table :roles do |t|
      t.remove :id
      t.remove :resource_id
      t.rename :uuid, :id
      t.rename :resource_uuid, :resource_id
    end    
    execute "ALTER TABLE roles ADD PRIMARY KEY (id);"

    add_column :users_roles, :user_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :users_roles, :role_uuid, :uuid, default: "gen_random_uuid()", null: false
    change_table :users_roles do |t|
      t.remove :user_id
      t.remove :role_id
      t.rename :user_uuid, :user_id
      t.rename :role_uuid, :role_id
    end
  end
end
