class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :username, null: false, unique: true
      t.string :password, null: false
      t.string :salt, null: false
      t.string :reset_token, null: false
      t.string :phone_number, null: false, default: ''
      t.string :name, default: ''
      t.boolean :is_private, default: false, null: false
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    #add_index :users, :phone_number, unique: true
  end
end
