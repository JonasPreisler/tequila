class ChangePriceName < ActiveRecord::Migration[5.2]
  def change
    rename_column :currencies, :price, :invested_at

  end
end
