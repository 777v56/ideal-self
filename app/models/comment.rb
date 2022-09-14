class Comment < ApplicationRecord
  has_one_attached :comment_image
  belongs_to :user
  belongs_to :mutter
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @comment = Comment.where("mutter LIKE?","#{word}")
    elsif search == "partial_match"
      @comment = Comment.where("mutter LIKE?","%#{word}%")
    else
      @comment = Comment.all
    end
  end

end
