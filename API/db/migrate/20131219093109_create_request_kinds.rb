class CreateRequestKinds < ActiveRecord::Migration
  def change
    create_table :request_kinds do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
