class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 1..50 }
  validates :email, presence: true, uniqueness: true, length: { in: 1..50 }
  validates :profile_comment, length: { maximum: 100 }
  validates :protein_target, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  mount_uploader :profile_image, ImageUploader
  has_many :foods, dependent: :destroy
  has_many :nutrition_records, dependent: :destroy
  has_many :active_friendships, foreign_key: 'follower_id', class_name: 'Friendship', dependent: :destroy
  has_many :passive_friendships, foreign_key: 'followed_id', class_name: 'Friendship', dependent: :destroy
  has_many :following, through: :active_friendships, source: :followed
  has_many :followers, through: :passive_friendships, source: :follower
  has_many :bmis, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :replies, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = 'guest'
    end
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def follow(other_user)
    active_friendships.create!(followed_id: other_user.id)
  end

  def following(other_user)
    active_friendships.find_by(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_friendships.find_by(followed_id: other_user.id).destroy
  end
end
