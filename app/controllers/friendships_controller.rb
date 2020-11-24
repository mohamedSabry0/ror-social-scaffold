class FriendshipsController < ApplicationController
    def create
        @user = User.find(params[:user_id])

        friendship =  @user.friendships.build(params[:friend_id])
        friendship.status = false
        friendship.save
    end
end
