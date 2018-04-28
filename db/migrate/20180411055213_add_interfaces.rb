class AddInterfaces < ActiveRecord::Migration[5.2]
  def up
    create_table :interfaces do |t|
      t.belongs_to :node, index: true
      t.string :name
      t.timestamps
    end

    create_table :macs do |t|
      t.belongs_to :interface, index: true
      t.string :address, unique: true
      t.timestamps
    end

    create_table :ip_addrs do |t|
      t.belongs_to :mac, index: true
      t.string :address, unique: true
      t.timestamps
    end

    remove_column :nodes, :management_ip_address
    remove_column :nodes, :internal_ip_address
  end

  def down
    drop_table :interfaces
    drop_table :macs
    drop_table :ip_addrs
  end
end
