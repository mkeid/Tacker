class Tracker < ActiveRecord::Base

  belongs_to :tracked_user,
             class_name: 'User',
             foreign_key: :tracked_user_id

  belongs_to :tracking_user,
             class_name: 'User',
             foreign_key: :tracking_user_id

end
