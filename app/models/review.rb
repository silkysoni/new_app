class Review < ApplicationRecord
  has_rich_text :content

  has_many_attached:pictures

  belongs_to :user
  belongs_to :product  

  belongs_to  :parent, class_name: 'Review', optional: true
  has_many    :replies, class_name: 'Review', foreign_key: :parent_id, dependent: :destroy

  validates :content, presence: true 

  def self.create_review(product, user, review_params)
    review = product.reviews.build(review_params.merge(user_id: user.id))

    if review.save
      review
    else
      nil
    end
  end

end
