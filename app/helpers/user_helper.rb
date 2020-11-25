module UserHelper
    def friendship_with(user)
        current_user.friendships.find_by_friend_id(user.id)
    end

    # def friendship_request?(user)
    #     return true if friendship_with(user)
    #     return false
    # end

    def friendship?(user)
        if friendship_with(user).nil?
            return ['Invite',
                    friendships_path(friend_id:user.id),
                    :post]
        end
        return ['delete request',
               friendship_path(friendship_with(user)),
               :delete]
    end
end