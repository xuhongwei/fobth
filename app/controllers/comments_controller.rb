class CommentsController < ApplicationController
  before_filter :load_commentable
  
  def create
    @comment = Comment.build_from( @commentable, current_user.id, params[:comment][:body] )
    @comment.save
    # if have parent
    if params[:comment][:parent_id].try(:to_i) > 0
      @parent = Comment.find(params[:comment][:parent_id])
      @comment.move_to_child_of(@parent)
    end
    redirect_to product_path(@commentable)
  end

  protected

  def load_commentable
    @commentable = Product.find(params[:comment][:commentable_id])
  end


end