class ChangeCostPerName < ActiveRecord::Migration[5.2]
  def change
    rename_column :currencies, :cost_per, :price
  end
end
