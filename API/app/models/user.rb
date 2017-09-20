class User < ActiveRecord::Base

  has_many :blocked_users,
           foreign_key: :blocking_user_id

  has_many :blocked_user_users,
           through: :blocked_users,
           class_name: 'User'

  has_many :friendships,
           foreign_key: :following_user_id

  has_many :friended_users,
           through: :friendships,
           class_name: 'User'

  has_many :recent_friendships,
           class_name: 'Friendship',
           foreign_key: :followed_user_id,
           order: 'created_at DESC',
           limit: 40

  has_many :requests,
           foreign_key: :requested_user_id,
           order: 'created_at DESC',
           limit: 40

  has_many :trackers,
           foreign_key: :tracking_user_id,
           order: 'created_at DESC',
           limit: 40

  has_one :push_device

  # Class methods.

  def self.hash_with_salt(password='', salt='')
    Digest::SHA2.hexdigest("Include a #{salt} with the #{password} to increase security")
  end

  def self.make_salt(email='')
    Digest::SHA2.hexdigest("Create a salt out of the user's #{email} and the current #{Time.now} to further secure the password")
  end

  # Instance methods.

  def ask_to_follow
    requests.create!(requesting_user_id: self.id, request_type_id: 2)
  end

  def ask_to_share_location
    requests.create!(requesting_user_id: self.id, request_type_id: 1)
  end

  def block
    blocked_users.create!(blocked_user_id: self.id)
  end

  def follow(followed_user)
    Friendship.create({following_user_id: self.id,
                       followed_user_id: followed_user.id})
    followed_user.send_push_notification("@#{self.username} befriended you.")
  end

  def send_push_notification(alert, custom_data)
    if self.push_device
      client = Houston::Client.production
      client.certificate = File.read('/usr/local/ssl/ApplePushProduction/ck.pem')
      client.passphrase = 'tacker'

      notification = Houston::Notification.new(device: self.push_device.token, alert: alert)
      notification.badge = self.requests.count + self.trackers.where(seen:false).count

      if custom_data
        notification.content_available = true
        notification.custom_data = custom_data
      end

      client.push(notification)
    end
  end

  def track(tracked_user, coordinates)
    tracker = Tracker.create({tracking_user_id: self.id,
                    tracked_user_id: tracked_user.id,
                    latitude: coordinates[:latitude],
                    longitude: coordinates[:longitude]})
    tracker
  end

  def unblock(blocked_user)
    BlockedUser.find_by_blocking_user_id_and_blocked_user_id(self.id, blocked_user.id).destroy
  end

  def unfollow
    friendships.find_by_followed_user_id(self.id).destroy
  end

end
