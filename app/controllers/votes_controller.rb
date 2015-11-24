class VotesController < ApplicationController

  before_action :authenticate_user

  def create
    # post = Post.find_by_id params[:post_id]
    vote = current_user.votes.new vote_params
    vote.post = post
    if vote.save
      redirect_to post_path(post), notice: "You voted for this post!"
    else
      redirect_to post_path(post), alert: "You can only vote once!"
    end
  end

  def update
    # post = Post.find_by_id params[:post_id]
    vote = current_user.posts.find params[:id]
    if vote.update vote_params
      redirect_to post_path(post), notice: "You have updated your vote."
    else
      redirect_to post_path(post), alert: "Vote was not updated."
    end
  end

  def destroy
    # post = Post.find_by_id params[:post_id]
    vote = current_user.votes.find params[:id]
    vote.destroy
    redirect_to post_path(post), notice: "You have removed your vote!"
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

  def post
    @post ||= Post.find params[:post_id]
  end


end
