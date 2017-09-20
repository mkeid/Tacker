class V1::SignoutController < ApplicationController
  before_action :current_user

  def index
    if @current_user.push_device.destroy
      render json: {success:true}
    end
  end
end
