class SearchesController < ApplicationController

  def search
    @posts = Post.all.search(params[:keyword]).order(created_at: :desc)
    @keyword = params[:keyword]
  end

end