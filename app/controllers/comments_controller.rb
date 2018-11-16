class CommentsController < ApplicationController
  respond_to :html
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = "Comment saved!"
    else
      flash[:error] = "Something went wrong... #{@comment.errors.messages.map { |k,v| [k, v].join(": ").capitalize }.join(", ") }"
    end
    respond_with Movie.find(params[:movie_id])
  end

  def destroy
    @comment = Comment.find_by(movie_id: params[:movie_id], user: current_user)

    if @comment.destroy
      flash[:notice] = "Comment removed!"
    end

    respond_with Movie.find(params[:movie_id])
  end

  private 

  def comment_params
    params.require(:comment).permit(:text).merge({ user_id: current_user.id, movie_id: params[:movie_id] })
  end
end
