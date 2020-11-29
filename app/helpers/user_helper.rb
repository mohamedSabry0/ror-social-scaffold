module UserHelper
  def friendship_links(user)
    if current_user.friend?(user)
      link_to('Unfriend',
              friendship_path(current_user.confirmed_friendships.find_by_user_id([user.id, current_user.id])),
              method: :delete,
              class: 'button')

    elsif current_user.pending_friends.include?(user)
      link_to('delete request',
              friendship_path(current_user.pending_friendships.find_by_friend_id(user.id)),
              method: :delete,
              class: 'button')

    elsif current_user.friend_requests.include?(user)
      link_to('Accept',
              accept_path(friendship_id: current_user.inverted_friendships.find_by_user_id(user.id).id),
              method: :post,
              class: 'button')\
        .concat(' ')\
        .concat(link_to('Reject',
                        friendship_path(current_user.inverted_friendships.find_by_user_id(user.id)),
                        method: :delete,
                        class: 'button'))

    else
      link_to("Invite #{user.name}",
              friendships_path(friend_id: user.id),
              method: :post,
              class: 'button')
    end
  end

  def find_mutual_friends
    if @mutual_friends.empty?
      content_tag :p, 'No mutual friends at the moment'
    else
      ((content_tag :h3, 'Mutual friends').to_s <<
        (render @mutual_friends).to_s).html_safe
    end
  end
end
