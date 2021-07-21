class SearchesController < ApplicationController

  def search
    @content = params["content"]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    if model == 'post'
      if method == 'perfect'
        Post.where(place_name: content)
      elsif method == 'partial'
        Post.where('name LIKE ?', '%'+content+'%')
      elsif method == 'forward'
        Post.where('name LIKE ?', '%'+content+'%')
      elsif method == 'backward'
        Post.where('name LIKE ?', '%'+content+'%')
      else
        Post.all
      end
    elsif model == 'post'
      if method == 'perfect'
        Post.where(title: content)
      elsif method == 'partial'
        Post.where('title LIKE ?', '%'+content+'%')
      elsif method == 'forward'
        Post.where('title LIKE ?', '%'+content+'%')
      elsif method == 'backward'
        Post.where('title LIKE ?', '%'+content+'%')
      else
        Post.all
      end
    elsif model == 'post'
      if method == 'perfect'
        Post.where(tag_name: content)
      elsif method == 'partial'
        Post.where('tag_name LIKE ?', '%'+content+'%')
      elsif method == 'forward'
        Post.where('tag_name LIKE ?', '%'+content+'%')
      elsif method == 'backward'
        Post.where('tag_name LIKE ?', '%'+content+'%')
      else
        Post.all
      end
    end
  end
end
