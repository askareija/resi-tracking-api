class TracksController < ApplicationController
  def index
    return render json: {message: 'no_resi is missing'}, status: :bad_request if params[:no_resi].nil? || params[:no_resi].empty?
    return render json: {message: 'expedition_type is missing'}, status: :bad_request if params[:expedition_type].nil? || params[:expedition_type].empty?

    track = TrackingService.track(params[:no_resi], params[:expedition_type])

    render json: track.to_json
  end
end
