module UserHelper
  def friendship_sender_side(user)
    if current_user.friendship_with(user).nil?
      link_to("Invite #{user.name}",
              friendships_path(friend_id: user.id),
              method: :post,
              class: 'button')

    elsif !current_user.friendship_with(user).status
      link_to('delete request',
              friendship_path(current_user.friendship_with(user)),
              method: :delete,
              class: 'button')

    elsif current_user.friend?(user)
      link_to('Unfriend',
              friendship_path(current_user.friendship_with(user)),
              method: :delete,
              class: 'button')
    end
  end

  def friendship_reciever_side(user)
    if current_user.friend?(user)
      link_to('Unfriend',
              friendship_path(current_user.inverse_friendship_with(user)),
              method: :delete,
              class: 'button')
    else
      link_to('Accept',
              accept_path(friendship_id: current_user.inverse_friendship_with(user).id),
              method: :post,
              class: 'button')\
        .concat(' ')\
        .concat(link_to('Reject',
                        friendship_path(current_user.inverse_friendship_with(user)),
                        method: :delete,
                        class: 'button'))
    end
  end

  def friendship?(user)
    if current_user.inverse_friendship_with(user).nil?
      friendship_sender_side(user)
    else
      friendship_reciever_side(user)
    end
  end

  def find_mutual_friends
    if @mutual_friends.empty?
      content_tag :p, 'No mutual friends at the moment'
    else
      ("#{content_tag :h3, 'Mutual friends'}" <<
        "#{render @mutual_friends}").html_safe
    end
  end
end
