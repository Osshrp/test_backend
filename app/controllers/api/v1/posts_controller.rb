class Api::V1::PostsController < ApplicationController
  before_action :authenticate
  set_pagination_headers :posts, only: [:index]

  def index
    @posts = Post.paginate(
                            page: params[:page],
                            per_page: params[:per_page]
                          ).order("published_at")
    render json: @posts
  end

  def show
    @post = Post.find params[:id]
    render json: @post
  end

  def create
    @post = Post.new post_params
    check_published_at
    @post.user = @current_user
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end

  def check_published_at
    unless post_params[:published_at]
      @post.published_at = DateTime.now
    end
  end
end
