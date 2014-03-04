class HomeController < ApplicationController
  def index
    @products = Product.all.page params[:page]
    @home = Home.first
    set_page_title "Home"
  end
end
