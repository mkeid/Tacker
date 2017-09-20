class V1::UsersController < ApplicationController
  #before_action :require_signin, :declare_user

  def test
    render json: User.first, serializer: V1::MeSerializer
  end
  def create
    email = params[:user][:email].downcase
    username = params[:user][:username].downcase

    if User.exists?(email:email)
      render json: {errors:'A user with that email already exists.'}
    else
      if User.exists?(username:username)
        render json: {errors:'A user with that username already exists.'}
      else
        user = User.new
        user.email = email
        user.salt = SecureRandom.hex
        user.password = User.hash_with_salt(params[:user][:password], user.salt)
        user.reset_token = SecureRandom.hex
        user.username = username
        if user.save
          session[:user] = {
              id: user.id
          }
          render json: user, serializer: V1::MeSerializer
        else
          render json: { :errors => true }
        end
      end
    end
  end

  def find_from_contacts
    current_user
    phone_numbers = params[:phone_numbers]
    users = User.where(:phone_number => phone_numbers).where.not(:id => @current_user.friendships.map(&:followed_user_id)).where.not(id: @current_user.id).where.not(phone_number: nil)
    render json: {
        users: users.map {|user|{id: user.id, phone_number:user.phone_number, username: user.username}},
    }
  end

  private

    def declare_user
      @user = User.find(user_simple_params)
    end

    def user_params
      params.require(:user).permit(:email, :username)
    end

    def user_simple_params
      params.require(:user_id)
    end

end
