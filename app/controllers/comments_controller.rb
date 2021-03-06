class CommentsController < ::BaseController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  def index
    @post = Post.includes(:author).find(params[:post_id])
    @comments = @post.comments.order(created_at: :asc).includes(:author).all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Post.find(params[:post_id]).comments.build
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = Post.find(params[:post_id]).comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to @comment.post, notice: 'Comment was successfully created.'
    else
      if request.xhr?
        render partial: "form", locals: { comment: @comment }
      else
        render :new
      end
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment.post, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Post.find(params[:post_id]).comments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:post_id, :user_id, :body)
    end
end
