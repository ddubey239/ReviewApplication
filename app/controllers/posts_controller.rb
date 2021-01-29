class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
      render json:Post.all,include: [:comments,:user]
  end

  def movie_user_post_index
    if (params[:id] && params[:movie_id])
      @user = User.find(params[:id])
      movie = Movie.find(params[:movie_id])
      post = Post.where(reviewable:movie, user:@user).first
      render json:post, include: [:user, :comments]
    else
      raise Exception.new "Movie post doesn't exist for this user"
    end
  end

  def user_post_index
    if(params[:id])
      @user = User.find(params[:id])
      post = Post.where(user:@user)
      render json: post.as_json
    else 
      raise Exception.new "Post doesn't exist for this user"
    end
  end

  def book_user_post_index
    if (params[:id] && params[:book_id])
      @user = User.find(params[:id])
      book = Book.find(params[:book_id])
      post = Post.where(reviewable:book, user:@user).first
      render json:post, include: [:user, :comments]
    else
      # render json:Post.all,include: [:comments,:user]
      raise Exception.new "Book post doesn't exist for this user"
    end
  end
  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:reviewable_type, :reviewable_id, :user_id)
    end
end
