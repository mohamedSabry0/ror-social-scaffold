module UserHelper
  def friendship_with(user)
    current_user.friendships.find_by_friend_id(user.id)
  end

  def inverse_friendship_with(user)
    current_user.inverse_friendships.find_by_user_id(user.id)
  end

  def friendship_sender_side(user)
    if friendship_with(user).nil?
      link_to("Invite #{user.name}",
              friendships_path(friend_id: user.id),
              method: :post,
              class: 'button')

    elsif !friendship_with(user).status
      link_to('delete request',
              friendship_path(friendship_with(user)),
              method: :delete,
              class: 'button')

    elsif current_user.friend?(user)
      link_to('Unfriend',
              friendship_path(friendship_with(user)),
              method: :delete,
              class: 'button')
    end
  end

  def friendship_reciever_side(user)
    if current_user.friend?(user)
      link_to('Unfriend',
              friendship_path(inverse_friendship_with(user)),
              method: :delete,
              class: 'button')
    else
      link_to('Accept',
              accept_path(friendship_id: inverse_friendship_with(user).id),
              method: :post,
              class: 'button')\
        .concat(' ')\
        .concat(link_to('Reject',
                        friendship_path(inverse_friendship_with(user)),
                        method: :delete,
                        class: 'button'))
    end
  end

  def friendship?(user)
    if inverse_friendship_with(user).nil?
      friendship_sender_side(user)
    else
      friendship_reciever_side(user)
    end
  end
end
