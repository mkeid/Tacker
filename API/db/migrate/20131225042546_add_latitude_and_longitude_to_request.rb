class AddLatitudeAndLongitudeToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :latitude, :decimal, precision: 15, scale: 11
    add_column :requests, :longitude, :decimal, precision: 15, scale: 11
  end
end
