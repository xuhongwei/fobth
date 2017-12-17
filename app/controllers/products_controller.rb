class ProductsController < ApplicationController
  def index
    if params[:category_id]
      category = Category.find(params[:category_id]);
      if category
        @products = category.products.page(params[:page])
        session[:query] = @products.map(&:id)
        set_page_title category.name
      end
    else
      @products = Product.page params[:page]
      session[:query] = @products.map(&:id)
      set_page_title "Products"
    end
  end

  def show
    @product = Product.friendly.find(params[:id])
    p @product
    @all_comments = @product.comment_threads
    @root_comments = @product.root_comments
    if session[:query]
      @next_product = @product.next(session[:query])
      @prev_product = @product.previous(session[:query])
    end
    set_page_title @product.name if @product
  end

  def search
    redirect_to "/" if (params[:q].nil? || params[:q].empty?)

    search_value = "%"+params[:q]+"%"
    @products = Product.where("description like ? or name like ?", search_value,search_value).page params[:page]
    session[:query] = @products.map(&:id)
    set_page_title "Search Result"
  end
end