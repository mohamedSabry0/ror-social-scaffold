class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm_friendship
    update_attributes(status: true)
    Friendship.create(
      user_id: friend_id,
      friend_id: user_id,
      status: true
    )
  end

  def remove_friendship
    friendship2 = Friendship.find_by_friend_id(user_id)
    destroy
    friendship2&.destroy
  end
end
