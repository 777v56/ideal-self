class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :mutter

  has_one_attached :comment_image

    # 検索方法分岐
  def self.looks(search, word)
    @comment = case search
      when "perfect_match"
        Comment.where("comment LIKE ?","#{word}")
      when "partial_match"
        Comment.where("comment LIKE ?","%#{word}%")
      else
        Comment.all
      end
  end

end