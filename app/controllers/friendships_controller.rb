class FriendshipsController < ApplicationController
    def create
        # @user = User.find(params[:user_id])

        @friendship =  current_user.friendships.build(friend_id:params[:friend_id], status:false)
        @friendship.save
        redirect_to users_path, notice: 'Friendship request was sented.'
    end
end
