class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], status: false)
    @friendship.save
    redirect_to users_path, notice: 'Friendship request was sented.'
  end

  def destroy
    @friendship1 = Friendship.find(params[:id])
    @friendship2 = Friendship.find_by_friend_id(@friendship1.user_id)
    @friendship1.destroy
    @friendship2&.destroy
    redirect_to users_path, notice: 'Friendship was deleted.'
  end

  def accept
    friendship = Friendship.find(params[:friendship_id])
    friendship.status = true
    friendship.save
    Friendship.create(
      user_id: friendship.friend_id,
      friend_id: friendship.user_id,
      status: true
    )
    redirect_to users_path, notice: 'Friendship request was accepted.'
  end
end
