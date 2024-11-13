class AddColumnToAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :content, :string
  end
end
