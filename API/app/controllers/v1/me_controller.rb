class V1::MeController < ApplicationController
  before_action :current_user

  def index
    render json: @current_user, serializer: V1::MeSerializer
  end

  def friendships
    render json: @current_user.friendships, each_serializer: V1::FriendshipSerializer, root: false
  end

  def recent_friendships
    render json: @current_user.recent_friendships, each_serializer: V1::RecentFriendshipSerializer, root: false
  end

  def requests
    render json: @current_user.requests, each_serializer: V1::RequestSerializer, root: false
  end

  def trackers
    render json: @current_user.trackers, each_serializer: V1::TrackerSerializer, root: false
  end

  def update_account
    email = params[:user][:email].downcase
    username = params[:user][:username].downcase
    is_private = params[:user][:is_private]
    phone_number = params[:user][:phone_number]

    if email != @current_user.email
      @current_user.email = email
    end

    if username != @current_user.username
      @current_user.username = username
    end

    if is_private != @current_user.is_private
      @current_user.is_private = is_private
    end

    if phone_number != @current_user.phone_number
      @current_user.phone_number = phone_number
    end

    if @current_user.save
      render json: @current_user, serializer: V1::MeSerializer
    else
      render json: @current_user.errors.full_messages
    end
  end

  def update_name
    name = params[:user][:name]
    @current_user.name = name
    if @current_user.save
      render json: @current_user, serializer: V1::MeSerializer
    else
      render json: @current_user.errors.full_messages
    end
  end

  def update_password
    passwords = params[:passwords]
    if passwords[:password2] === passwords[:password3] && passwords[:password1] != passwords[:password2]
      hashed_password = User.hash_with_salt(passwords[:password1], @current_user.salt)
      if @current_user.password == hashed_password
        @current_user.password = User.hash_with_salt(passwords[:password2], @current_user.salt)
        if @current_user.save
          render json: {success:true}
        else
          render json: @current_user.errors.full_messages
        end
      else
        render json: {
            errors: true
        }
      end
    else
      render json: {
          errors: true
      }
    end
  end

  def update_push_device
    if @current_user.push_device
      if @current_user.push_device.update_attributes(token: params[:token])
        render json: {success: true}
      end
    else
      if PushDevice.create({user_id: @current_user.id, token: params[:token]})
        render json: {success: true}
      end
    end
  end

end
