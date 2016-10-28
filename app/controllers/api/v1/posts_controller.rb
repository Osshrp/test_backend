class Api::V1::PostsController < ApplicationController
  before_action :authenticate
  before_action :paginate, only: :index
  before_action :load_post, only: :create
  set_pagination_headers :posts, only: :index

  respond_to :json

  def index
    respond_with :api, :v1, @posts
  end

  def show
    respont_with :api, :v1, @post
  end

  def create
    @post.save
    respond_with :api, :v1, @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end

  def load_post
    @post = Post.new post_params
    check_published_at
    @post.user = @current_user
  end

  def check_published_at
    unless post_params[:published_at]
      @post.published_at = DateTime.now
    end
  end

  def paginate
    @posts = Post.paginate(
                            page: params[:page],
                            per_page: params[:per_page]
                          ).order("published_at")
  end
end
