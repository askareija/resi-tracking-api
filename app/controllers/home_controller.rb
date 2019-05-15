# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    { json: { message: "Hello. #{current_user}" } }
  end
end
