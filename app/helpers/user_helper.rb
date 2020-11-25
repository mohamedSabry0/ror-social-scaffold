module UserHelper
  def friendship_with(user)
    current_user.friendships.find_by_friend_id(user.id)
  end

  def inverse_friendship_with(user)
    current_user.inverse_friendships.find_by_user_id(user.id)
  end

  def friendship?(user)
    if inverse_friendship_with(user).nil?
      if friendship_with(user).nil?
        ["Invite #{user.name}",
         friendships_path(friend_id: user.id),
         :post]
      elsif !friendship_with(user).status
        ['delete request',
         friendship_path(friendship_with(user)),
         :delete]
      elsif current_user.friend?(user)
        ['Unfriend',
         friendship_path(friendship_with(user)),
         :delete]
      end
    else
      if current_user.friend?(user)
        return ['Unfriend',
                friendship_path(inverse_friendship_with(user)),
                :delete]
      end
      ['Accept',
       accept_path(friendship_id: inverse_friendship_with(user).id),
       :post]
    end
  end
end
