class V1::RequestsController < ApplicationController
  before_action :current_user, :declare_request
  skip_before_action :declare_request, only: [:create]

  def approve
    requesting_user = @request.requesting_user
    if @request.kind == 'Friendship'
      if requesting_user.follow(@current_user) && @request.destroy
        requesting_user.send_push_notification("@#{@current_user.username} approved your friendship request.", {kind:'Friendship'})
        render json: {success:true}
      end
    elsif @request.kind == 'Tracker'
      coordinates = {latitude: @request.latitude, longitude: @request.longitude}
      tracker_on_requesting_user = @current_user.track(requesting_user, coordinates)
      tracker_on_requesting_user.updated_at = @request.created_at
      tracker_on_current_user = requesting_user.track(@current_user, params[:coordinates])
      if tracker_on_current_user.save && tracker_on_requesting_user.save && @request.destroy
        requesting_user.send_push_notification("@#{@current_user.username} approved your tracker request.", {kind:'Tracker'})
        render json: tracker_on_requesting_user, serializer: V1::TrackerSerializer
      end
    end
  end

  def create
    user = User.find(params[:request][:requested_user_id])
    request = Request.new({requesting_user_id: @current_user.id, requested_user_id: params[:request][:requested_user_id]})
    request.request_kind_id = RequestKind.find_by_name(params[:request][:kind]).id
    case request.kind
      when 'Friendship'
        if !@current_user.friended_users.include?(user)
          if user.is_private && request.save
            user.send_push_notification("@#{@current_user.username} wants to be your friend.", {kind:'Request'})
            render json: {success:true}
          elsif @current_user.follow(user)
            render json: {success:true}
          end
        else
          render json: {errors:true}
        end
      when 'Tracker'
        request.update_attributes(latitude: params[:request][:latitude], longitude: params[:request][:longitude])
        if @current_user.friended_users.include?(user)
          if request.save
            user.send_push_notification("@#{@current_user.username} wants to share locations with you.", {kind:'Request'})
            render json: request, serializer: V1::RequestSerializer
          else
            render json: {errors:request.error.full_messages}
          end
        else
        end
    end
  end

  def destroy
    if @current_user.requests.include?(@request) && @request.destroy
      render json: {success:true}
    else
      render json: {errors:@request.error.full_messages}
    end
  end

  private

    def declare_request
      request = Request.find(params[:request][:id])
      if @current_user.requests.include? request
        @request = request
      end
    end

    def request_simple_params
      params.require(:request_id)
    end

end
