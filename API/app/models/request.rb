class Request < ActiveRecord::Base

  belongs_to :requested_user,
             class_name: 'User',
             foreign_key: :requested_user_id

  belongs_to :requesting_user,
             class_name: 'User',
             foreign_key: :requesting_user_id

  def kind
    RequestKind.find(self.request_kind_id).name
  end

end
