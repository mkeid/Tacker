class AddLatitudeAndLongitudeToTracker < ActiveRecord::Migration
  def change
    add_column :trackers, :latitude, :decimal, precision: 15, scale: 10, null: false
    add_column :trackers, :longitude, :decimal, precision: 15, scale: 10, null: false
  end
end
