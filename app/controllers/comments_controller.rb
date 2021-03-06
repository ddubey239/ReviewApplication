class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    if(params[:post_id])
    post = Post.find(params[:post_id])
    render json:post.comments.as_json
    else 
      comments = Comment.all
      render json: comments
    end
  end

  def movie_user_post_comment_index
    if (params[:id] && params[:movie_id] && params[:user_id])
      @user = User.find(params[:user_id])
      @movie = Movie.find(params[:movie_id])
      @post = Post.where(reviewable:@movie, user:@user)
      comment = Comment.where(post:@post)
      render json: comment
    else
      raise Exception.new "Comments for this movie post doesn't exist for this user"
    end
  end

  def book_user_post_comment_index
    if (params[:id] && params[:book_id] && params[:user_id])
      @user = User.find(params[:user_id])
      @book = Book.find(params[:book_id])
      @post = Post.where(reviewable:@book, user:@user)
      comment = Comment.where(post:@post)
      render json: comment
    else
      raise Exception.new "Comments for this Book post doesn't exist for this user"
    end
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:reply, :post_id)
    end
end
