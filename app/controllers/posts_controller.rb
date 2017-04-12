class PostsController < ::BaseController
  skip_before_filter :authenticate_user!, only: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts
  def index
    @posts = Post.includes(:author).order(created_at: :desc)
  end

  # GET /posts/1
  def show
    @post.comments.build  # New record for comment form.
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
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
      @post = Post.includes(:author).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :user_id, :body)
    end
end
