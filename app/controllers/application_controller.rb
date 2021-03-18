# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthConcern
  include FlashConcern
  include Pundit
end
