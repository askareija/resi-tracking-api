# frozen_string_literal: true

class TracksController < ApplicationController
  # before_action :authenticate_request!

  def index
    return render json: { message: 'no_resi is missing' }, status: :bad_request if params[:no_resi].nil? || params[:no_resi].empty?
    return render json: { message: 'expedition_type is missing' }, status: :bad_request if params[:expedition_type].nil? || params[:expedition_type].empty?

    track = TrackingService.track(params[:no_resi], params[:expedition_type], @current_user)

    if track.nil?
      render json: {message: 'receipt not found'}, status: :not_found
    else
      render json: track.to_json
    end
  end

  def histories
    # render json: @current_user.track_histories.to_json
    render json: TrackHistory.where(user_id: 1).to_json
  end

  def history
    render json: @current_user.track_histories.where(id: params[:id]).first.to_json
  end
end
