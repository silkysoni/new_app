class Category < ApplicationRecord
    has_many :sub_categories ,dependent: :destroy
   
    validates :category_name, presence: true 
end