class RemoveRankFromCurrencies < ActiveRecord::Migration[5.2]
  def change
	remove_column :currencies, :rank
  end
end
