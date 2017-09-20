class V1::FriendshipsController < ApplicationController
  before_action :current_user#, :declare_friendship
  #skip_before_action :declare_friendship, only: :create

  def ask_to_create
    request = Request.new({requesting_user_id: @current_user.id,
                           requested_user_id: @user.id,
                           request_kind_id: RequestKind.find_by_name('Friendship').id})
    if request.save
      render json: {success: true, alerts: "A friendship request has been sent to the private user #{@user.username}"}
    else
      render json: {alerts: 'A friendship request has already been sent to this private user.'}
    end
  end

  def create
    declare_user
    if @user
      if @current_user.blocked_user_users.include?(@user) || @user.blocked_user_users.include?(@current_user)
        render json: {alerts: 'You cannot friend this user. You are either blocking them or he/she is blocking you.'}
      else
        if !@current_user.friended_users.include?(@user)
          if @user.is_private
            ask_to_create
          else
            friendship = Friendship.create({following_user_id: @current_user.id, followed_user_id: @user.id})
            if params[:friendship] && params[:friendship][:followed_user_name]
              friendship.followed_user_name = params[:friendship][:followed_user_name]
            end
            if friendship.save
              @user.send_push_notification("@#{@current_user.username} befriended you.", {kind:'Friendship'})
              render json: friendship, serializer: V1::FriendshipSerializer
            else
              render json: { :errors => nil }
            end
          end
        else
          render json: {alerts: 'You are already friends with this user.'}
        end
      end
    else
      render json: {alerts: 'A user with that username does not exist.'}
    end
  end

  def destroy
    declare_friendship
    if @friendship.destroy
      render json: {success: true}
    else
      render json: { :errors => nil }
    end
  end

  def update
    declare_friendship
    @friendship.followed_user_name = params[:friendship][:followed_user_name]
    if @friendship.save
      render json: @friendship, serializer: V1::FriendshipSerializer
    else
      render json: { :errors => nil }
    end
  end

  private

    def declare_friendship
      if params[:friendship][:id]
        friendship =  Friendship.find(params[:friendship][:id])
        if @current_user.friendships.include?(friendship)
          @friendship = friendship
        end
      elsif params[:friendship][:followed_user_id]
        friendship = Friendship.find_by_following_user_id_and_followed_user_id(@current_user.id, params[:friendship][:followed_user_id])
        if @current_user.friendships.include?(friendship)
          @friendship = friendship
        end
      end
    end

    def declare_user
      if params[:friendship]
        @user = User.find(params[:friendship][:followed_user_id])
      elsif params[:user]
        @user = User.find_by_username(params[:user][:username])
      end
    end

    def friendship_simple_params
      params.require(:followed_id)
    end

    def user_simple_params
      params.require(:user_id)
    end

end
