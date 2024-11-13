class ReviewsController < ApplicationController
  before_action :set_product, only: [:index, :new, :create]

  def index
    @review = Review.new
  end

  def new
    @review = Review.new
    @parent_id = params[:parent_id]

    respond_to do |format|
      format.html { render :new, layout: false }
      format.js
    end
  end

  # def create
  #   @review = @product.reviews.build(review_params.merge(user_id: current_user.id))

  #   if @review.save
  #     redirect_to product_reviews_path(@product), notice: "Review added successfully!"
  #   else
  #     @reviews = @product.reviews
  #     render :index
  #   end
  # end
  # 
  def create
    @review = Review.create_review(@product, current_user, review_params)

    if @review
      redirect_to product_reviews_path(@product), notice: "Review added successfully!"
    else
      @reviews = @product.reviews
      render :index
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:body, :content, :parent_id, pictures: [])
  end
end
