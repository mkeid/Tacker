class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.integer :tracking_user_id, null: false
      t.integer :tracked_user_id, null: false
      t.boolean :seen, default: false, null: false
      t.timestamps
    end
  end
end
