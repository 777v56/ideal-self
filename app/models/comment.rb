class Comment < ApplicationRecord
  has_one_attached :comment_image
  belongs_to :user
  belongs_to :mutter
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
