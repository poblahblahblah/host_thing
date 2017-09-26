class CreateDatacenters < ActiveRecord::Migration[5.1]
  def change
    create_table :datacenters do |t|
      t.string :name
      t.string :vendor
      t.string :provider

      t.timestamps
    end
  end
end
