class LikesController < ApplicationController

  before_action :authenticate_user

  def create
    like = Like.new
    post = Post.friendly.find params[:post_id]
    like.post = post
    like.user = current_user
    if like.save
      redirect_to post_path(post), notice: "You now Like this post. Thanks for liking!"
    else
      redirect_to post_path(post), alert: "You cannot Like a post more than once."
    end
  end

  def destroy
    like = current_user.likes.find_by_id params[:id]
    post = Post.friendly.find_by_id params[:post_id]
    like.destroy
    redirect_to post_path(post), notice: "You have removed your Like form this post."
  end

end
