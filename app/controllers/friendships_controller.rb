class FriendshipsController < ApplicationController
    def create
        @friendship =  current_user.friendships.build(friend_id:params[:friend_id], status:false)
        @friendship.save
        redirect_to users_path, notice: 'Friendship request was sented.'
    end

    def destroy
        @friendship = current_user.friendships.find(params[:id])
        @friendship.destroy
        redirect_to users_path, notice: 'Friendship request was deleted.'
    end
end
