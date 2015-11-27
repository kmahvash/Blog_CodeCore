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
    @post = Post.friendly.find params[:post_id]
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post
    respond_to do |format|
      if @comment.save
        CommentsMailer.notify_post_owner(Comment.last).deliver_later
        format.html {redirect_to post_path(@post), notice: "Your comment was successfuly created."}
        format.js   {render :create_success}
      else
        format.html {redirect_to post_path(@post)}
        format.js   {render :create_failure}
      end
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
    redirect_to root_path, alert: "Access denied: Only the author of a comment or the corresponding post could delete a comment." unless can? :destroy, @comment
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to post_path(@comment.post), notice: "The selected comment was successfully deleted."}
      format.js   {render}
    end
  end


  private

  def find_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    comment_params = params.require(:comment).permit(:title, :body)
  end


end
