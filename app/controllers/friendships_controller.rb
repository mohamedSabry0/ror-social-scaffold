class FriendshipsController < ApplicationController
  def create
    current_user.friendships.create!(friend_id: params[:friend_id], status: false)
    redirect_to users_path, notice: 'Friendship request was sented.'
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.remove_friendship
    redirect_to users_path, notice: 'Friendship was deleted.'
  end

  def accept
    friendship = Friendship.find(params[:friendship_id])
    friendship.confirm_friendship
    redirect_to users_path, notice: 'Friendship request was accepted.'
  end
end
