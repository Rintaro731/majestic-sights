class PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    @post_comment = PostComment.new
    @post_tags = @post.tags
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(",")
    if @post.save
      @post.save_posts(tag_list)
      redirect_to post_path(@post.id), success: '正常に投稿されました｡'
    else
      redirect_to posts_path, danger: '投稿に失敗しました'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, denger: '投稿が削除されました｡'
  end

  private

  def post_params
    params.require(:post).permit(:image, :address, :title, :body)
  end

end
