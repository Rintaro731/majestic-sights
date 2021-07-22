class Post < ApplicationRecord

  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  attachment :image

  validates :image, presence: true
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 500}
  validates :address, presence: true

  #住所から緯度と経度を計算
  geocoded_by :address
  after_validation :geocode

  def favorited_by?(post)
    favorites.where(post_id: post.id).exists?
  end

  def self.search(keyword)
    where(["title like? OR body like? OR address like?" , "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  def save_posts(savepost_tags)
  # 現在のユーザーの持っているskillを引っ張ってきている
  current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
  # 今postが持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
  old_tags = current_tags - savepost_tags
  # 今回保存されたものと現在の差を新しいタグとする。新しいタグは保存
  new_tags = savepost_tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name:new_name)
      # 配列に保存
      self.tags << post_tag
    end
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tag.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end

  def user
  #インスタンスメソッドないで、selfはインスタンス自身を表す
    return User.find_by(id: self.user_id)
  end

end
