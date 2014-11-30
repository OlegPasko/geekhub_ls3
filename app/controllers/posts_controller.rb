class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  after_action :update_views#, except: :index

  # GET /posts
  def index
    @posts = Post.all
    # @name = params[:name]
    # render json: {error: 'error_msg'}, status: :ok
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.json { render json: @post.to_json }
      format.html
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(params.require(:post).permit(:title, :body))
    @post.user = User.first

    if @post.save
      #add post to table
    else
      #some alert
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body, :image)
    end

    def update_views
      cookies[:views] = if cookies[:views].present?
                          cookies[:views].to_i + 1
                        else
                          1
                        end
    end
end