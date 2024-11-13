class SubCategory < ActiveRecord::Migration[7.1]
  def change
    create_table :sub_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.string :subcategory_name
      t.timestamps
    end
  end
end
