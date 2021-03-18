# frozen_string_literal: true

class Web::WhiskiesController < Web::ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @whiskies = Whisky.includes(:brand).order(id: :desc)
  end

  def show
    @whisky = Whisky.find(params[:id])
  end
end
