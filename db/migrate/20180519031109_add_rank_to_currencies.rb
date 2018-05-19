class AddRankToCurrencies < ActiveRecord::Migration[5.2]
  def change
    add_column :currencies, :rank, :integer
  end
end
