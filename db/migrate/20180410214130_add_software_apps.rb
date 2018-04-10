class AddSoftwareApps < ActiveRecord::Migration[5.1]
  def up
    create_table :software_apps do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    create_join_table :roles, :software_apps do |t|
      t.index [:role_id, :software_app_id], :unique => true
      t.index [:software_app_id, :role_id], :unique => true
    end
  end

  def down
    drop_table :software_apps
    drop_join_table :roles, :software_apps
  end
end
