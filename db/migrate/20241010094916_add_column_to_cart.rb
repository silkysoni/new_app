class AddColumnToCart < ActiveRecord::Migration[7.1]
  def change
    add_reference :carts, :address, null: true, foreign_key: true
  end
end
