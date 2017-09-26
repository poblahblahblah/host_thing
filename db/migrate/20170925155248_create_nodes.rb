class CreateNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :fqdn
      t.string :serial
      t.string :internal_ip_address
      t.string :management_ip_address

      t.integer :datacenter_id
      t.integer :operating_system_id
      t.integer :status_id

      t.timestamps
    end
  end
end
