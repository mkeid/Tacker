class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :following_user_id, null: false
      t.integer :followed_user_id, null: false
      t.string :followed_user_name, null: false, default: ''
      t.timestamps
    end
    add_index :friendships, [:following_user_id, :followed_user_id], unique: true
  end
end
