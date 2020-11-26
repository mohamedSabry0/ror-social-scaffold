class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, foreign_key: :user_id
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  has_many :friends, through: :friendships

  def friends_list
    friends_array = friendships.map { |friendship| friendship.friend if friendship.status }
    friends_array.concat(inverse_friendships.map { |friendship| friendship.user if friendship.status })
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  def friend?(user)
    friends_list.include?(user)
  end

  def friendship_with(user)
    friendships.find_by_friend_id(user.id)
  end

  def inverse_friendship_with(user)
    inverse_friendships.find_by_user_id(user.id)
  end
end
