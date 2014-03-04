class NewsController < ApplicationController
  def index
    @news = News.all
    set_page_title "About Us"
  end

  def show
    @news = News.find(params[:id])
    set_page_title @news.title if @news
  end
end
