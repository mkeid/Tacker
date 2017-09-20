class CreateBlockedUsers < ActiveRecord::Migration
  def change
    create_table :blocked_users do |t|
      t.integer :blocking_user_id, null: false
      t.integer :blocked_user_id, null: false
      t.timestamps
    end
    add_index :blocked_users, [:blocking_user_id, :blocked_user_id], unique: true
  end
end
