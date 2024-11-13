class Cart < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :subtotal
      t.boolean :ordered, default: false
      t.timestamps
    end
  end
end

