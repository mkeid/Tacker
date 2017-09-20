class V1::AuthController < ApplicationController

  def reset_password
  end

  def send_reset_token
  end

  def signin
    signin = params[:user][:signin].downcase
    password = params[:user][:password]

    signin_type = 'username'
    if signin.include? '@'
      signin_type = 'email'
    end

    user_present = false
    if signin_type == 'username'
      user_present = true if User.where(username: signin).present?
    elsif signin_type == 'email'
      user_present = true if User.where(email: signin).present?
    end

    # Check if the user exists.
    if user_present
      if signin_type == 'username'
        user = User.find_by_username(signin)
      elsif signin_type == 'email'
        user = User.find_by_email(signin)
      end

      # Check if the password is correct.
      hashed_password = User.hash_with_salt(password, user.salt)
      if user.password == hashed_password
        session[:user] = {
            id: user.id,
        }
        render json: user, serializer: V1::MeSerializer
      else
        render json: {
            errors: 'Invalid sign in credentials.'
        }
      end
    else
      render json: {
          errors: 'Invalid sign in credentials.'
      }
    end
  end

  def signout
    reset_session
  end

end
