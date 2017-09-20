class Friendship < ActiveRecord::Base
  #set_primary_keys :following_user_id, :followed_user_id

  belongs_to :friended_user,
             class_name: 'User',
             foreign_key: :followed_user_id

  belongs_to :friending_user,
             foreign_key: :following_user_id

  before_destroy { |friendship| Request.destroy_all "requesting_user_id = #{friendship.following_user_id} AND requested_user_id = #{friendship.followed_user_id}" }
  before_destroy { |friendship| Request.destroy_all "requesting_user_id = #{friendship.followed_user_id} AND requested_user_id = #{friendship.following_user_id}" }
  before_destroy { |friendship| Tracker.destroy_all "tracking_user_id = #{friendship.following_user_id} AND tracked_user_id = #{friendship.followed_user_id}" }
  before_destroy { |friendship| Tracker.destroy_all "tracking_user_id = #{friendship.followed_user_id} AND tracked_user_id = #{friendship.following_user_id}" }

end
