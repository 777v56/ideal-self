class Mutter < ApplicationRecord

  has_one_attached :mutter_image

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @mutter = Mutter.where("mutter LIKE?","#{word}")
    elsif search == "partial_match"
      @mutter = Mutter.where("mutter LIKE?","%#{word}%")
    else
      @mutter = Mutter.all
    end
  end

end
