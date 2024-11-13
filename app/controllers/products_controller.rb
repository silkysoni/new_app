class ProductsController < ApplicationController
  before_action :set_wishlist_items, only: [:index, :show]

  def index
    @products = Product.all

    if params[:query].present?
      search_item
    end

    if params[:price_range].present?
      select_price_range
    end

    if params[:category].present?
      select_category
    end

    @price_ranges = [
      { label: "Under ₹500", min: 0, max: 500 },
      { label: "₹500 - ₹1000", min: 500, max: 1000 },
      { label: "₹1000 - ₹5000", min: 1000, max: 5000 },
      { label: "₹5000 - ₹10,000", min: 5000, max: 10000 },
      { label: "Over ₹10,000", min: 10000, max: 100000 },
    ]

    @categories = Category.pluck(:category_name)
  end

  def new
    @product = Product.new
    @categories = Category.all
    @sub_categories = []
  end

  def create
    @product = Product.new(product_params)
    @product=Product
    if @product.save
      redirect_to product_path, notice: "Product registered!"
    else
      flash[:error] = @product.errors.full_messages
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def sub_categories
    if params[:category_id]
      @sub_categories = SubCategory.where(category_id: params[:category_id])
      render json: @sub_categories.select(:id, :subcategory_name)
    else
      render json: []
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :image, :sub_category_id)
  end

  def set_wishlist_items
    @wishlist_items = user_signed_in? ? current_user.wishlist_items.pluck(:product_id) : []
  end

  def search_item
    query = params[:query].downcase.strip
    @products = @products.joins(sub_category: :category)
                         .where("LOWER(products.name) LIKE :query OR LOWER(sub_categories.subcategory_name) LIKE :query 
                                OR LOWER(categories.category_name) LIKE :query", query: "%#{query}%")
                         .distinct
  end

  def  select_price_range
    price_min, price_max = params[:price_range].split(",").map(&:to_i)
    @products = 
      if price_max == 100000
        @products.where("price >= ?", price_min)
      else
        @products.where(price: price_min..price_max)
      end
  end

  def select_category
    category = Category.find_by(category_name: params[:category])
    @products = []
    if category
      @products = Product.joins(sub_category: :category)
                        .where(sub_categories: { category_id: category.id })
                        .includes(:sub_category)   
    end
  end


end
