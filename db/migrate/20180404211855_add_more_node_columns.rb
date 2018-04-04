class AddMoreNodeColumns < ActiveRecord::Migration[5.1]
  def change

    add_column :nodes, :contract_start_date, :datetime
    add_column :nodes, :contract_end_date, :datetime

  end
end
