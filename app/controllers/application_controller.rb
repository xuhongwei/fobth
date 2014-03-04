class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery with: :exception
  before_filter :init_categroies

  private
  
  def init_categroies
    @categories = Category.order("sequence")
    @hots = Hot.order("sequence")
    @links = Link.order("sequence")
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
