class AllowNodesToHaveMultipleRoles < ActiveRecord::Migration[5.1]
  def change
    create_join_table :nodes, :roles do |t|
      t.index [:role_id, :node_id], :unique => true
      t.index [:node_id, :role_id], :unique => true
    end
  end

  def up
    remove_column :nodes, :role_id
  end

  def down
    add_column :nodes, :role_id
  end
end
