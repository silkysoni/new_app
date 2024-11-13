class AddParentIdToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :parent_id, :integer
  end
end
