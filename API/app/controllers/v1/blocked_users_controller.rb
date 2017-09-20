class V1::BlockedUsersController < ApplicationController

  before_action :current_user, :declare_user

  def create
    blocked_user = BlockedUser.new({blocking_user_id: @current_user.id, blocked_user_id: @user.id})
    if blocked_user.save
      render json: blocked_user, serializer: V1::BlockedUserSerializer
    else
      render json: {alerts: 'This user is already blocked.'}
    end
  end

  def destroy
    if @current_user.blocked_user_users.include?(@user)
      if @current_user.unblock(@user)
        render json: {success: true}
      else
        render json: { :errors => @user.errors.full_messages }
      end
    else
      render json: { :errors => 'User is not blocked.' }
    end
  end

private

  def declare_user
    @user = User.find(params[:blocked_user][:blocked_user_id])
  end

end
