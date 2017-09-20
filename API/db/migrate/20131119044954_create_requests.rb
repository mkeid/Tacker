class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requesting_user_id, null: false
      t.integer :requested_user_id, null: false
      t.integer :request_kind_id, null: false
      t.timestamps
    end
    add_index :requests, [:requesting_user_id, :requested_user_id], unique: true
  end
end
