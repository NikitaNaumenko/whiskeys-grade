# frozen_string_literal: true

class Api::Whiskies::ApplicationController < Api::ApplicationController
  def resource_whisky
    @resource_whisky ||= Whisky.find(params[:whisky_id])
  end
end
