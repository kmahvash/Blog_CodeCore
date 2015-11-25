class PostsController < ApplicationController

  before_action :authenticate_user, except: [:show, :index]

  before_action(:find_post, {only: [:show, :edit, :update, :destroy]})

  before_action :authorize, only: [:edit, :update, :destroy]

  def new
    authenticate_user
    @post = Post.new
  end


  def create
    # post_params = params.require(:post).permit(:title, :body)
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to (post_path(id: @post.id))
    else
      render new
    end
  end


  def show
    # @post = Post.find params[:id]
    @comment = Comment.new
  end


  def index
    @query = params[:query]
    if @query
      @posts = Post.order(:created_at).page(params[:page]).search(params[:query])
    else
      @posts = Post.order(:created_at).page(params[:page])
    end
  end


  def edit
    # @post = Post.find params[:id]
      # redirect_to posts_path, alert: "Access denied: Only the author of a post could edit or delete it." unless can? :edit, @post
  end


  def update
    # @post = Post.find params[:id]
    # post_params = params.require(:post).permit(:title, :body)
    if @post.update(post_params)
      flash[:notice] = "Post successfully updated"
      redirect_to post_path(id: @post.id)
    else
      redirect_to edit_post_path(id: @post.id)
    end
  end


  def destroy
    # @post = Post.find params[:id]
    @post.destroy
    flash[:alert] = "Post successfully deleted."
    redirect_to posts_path
  end



  private

  def find_post
    @post = Post.friendly.find params[:id]
  end

  def post_params
    post_params = params.require(:post).permit(:title, :body, {label_ids:[]})
  end

  def authorize
    redirect_to root_path, alert: "Access denied: Only the author of a post could edit or delete it." unless can? :manage, @post
  end

end
