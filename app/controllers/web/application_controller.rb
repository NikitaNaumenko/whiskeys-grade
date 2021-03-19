# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  before_action do
    gon.current_user = if current_user.guest?
                         GuestSerializer.new(current_user)
                       else
                         UserSerializer.new(current_user)
                       end
    gon.token = form_authenticity_token
  end
end
