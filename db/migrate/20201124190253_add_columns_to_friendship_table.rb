class AddColumnsToFriendshipTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :friendships, :user, references: :users, index: true
    add_foreign_key :friendships, :users, column: :user_id
    add_reference :friendships, :friend, references: :users, index: true
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
