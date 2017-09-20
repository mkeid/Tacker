class V1::TrackersController < ApplicationController
  before_action :current_user, :declare_tracker
  skip_before_action :declare_tracker, only: [:trackers_with_user]

  def destroy
    if @tracker.destroy
      render json: {success:true}
    end
  end

  def see
    if @current_user.trackers.include? @tracker
      if @tracker.update_attributes({seen: true})
        render json: @tracker, serializer: V1::TrackerSerializer
      end
    end
  end

  def trackers_with_user
    trackers = Tracker.where(tracking_user_id: @current_user).where(tracked_user_id: params[:tracker][:tracked_user_id])
    render json: trackers, each_serializer: V1::TrackerSerializer
  end

  private

  def declare_tracker
    tracker = Tracker.find(params[:tracker][:id])
    if @current_user.trackers.include? tracker
      @tracker = tracker
    end
  end

end
