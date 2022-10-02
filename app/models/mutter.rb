class Mutter < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tags, dependent: :destroy
  belongs_to :user

  has_one_attached :mutter_image

  validates :mutter, presence: true, length: { maximum: 200 }

  # 検索方法分岐
  def self.looks(search, word)
    @mutter = case search
      when "perfect_match"
        Mutter.where("mutter LIKE ?","#{word}")
      when "partial_match"
        Mutter.where("mutter LIKE ?","%#{word}%")
      else
        Mutter.all
      end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end