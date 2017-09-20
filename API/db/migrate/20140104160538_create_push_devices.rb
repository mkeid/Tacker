class CreatePushDevices < ActiveRecord::Migration
  def change
    create_table :push_devices do |t|
      t.integer :user_id, null: false, unique: true
      t.string :token, null: false, unique: true
      t.timestamps
    end
    add_index :push_devices, :user_id, unique: true
    add_index :push_devices, :token, unique: true
  end
end
