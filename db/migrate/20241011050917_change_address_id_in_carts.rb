class ChangeAddressIdInCarts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :carts, :address_id, true
  end
end
