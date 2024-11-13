class SubCategory < ApplicationRecord
    belongs_to :category  
    has_many :products ,dependent: :destroy
    

    validates :subcategory_name, presence: true 
end