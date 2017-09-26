class CreateRoles < ActiveRecord::Migration[5.1]
  def up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end

    add_column :nodes, :role_id, :integer
  end
end
