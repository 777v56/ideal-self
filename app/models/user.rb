class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :introduction, Length: { maximum: 100 }
  validates :name, presence: true, uniqueness: true, Length: { maximum: 15 }

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.birthday = "20000101"
    end
  end

  enum gender: { men: 0, women: 1, secret: 2 }

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'ノーイメージ.jpg'
  end

  has_many :mutters, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :records, dependent: :destroy

  has_many :favorites, dependent: :destroy
  # 一覧画面で使う
  has_many :favorited_mutters, through: :favorites, source: :mutter

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end