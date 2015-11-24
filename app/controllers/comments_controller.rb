class CommentsController < ApplicationController

  before_action :authenticate_user, except: [:index, :show]

  before_action :find_comment, only: [:edit, :update, :show, :destroy]

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def create
    @post = Post.find params[:post_id]
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post), notice: "Your comment was successfuly created."
    else
      redirect_to post_path(@post)
    end
  end

  # def edit
  #
  # end
  #
  # def update
  #   if @comment.update(comment_params)
  #     redirect_to comments_path, alert: "The selected comment was successfully updated."
  #   else
  #     render :edit
  #   end
  # end
  #
  # def show
  #
  # end

  def destroy
    @comment.destroy
    redirect_to root_path, alert: "Access denied: Only the author of a comment or the corresponding post could delete a comment." unless can? :destroy, @comment
    redirect_to post_path(@comment.post), notice: "The selected comment was successfully deleted."
  end


  private

  def find_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    comment_params = params.require(:comment).permit(:title, :body)
  end


end