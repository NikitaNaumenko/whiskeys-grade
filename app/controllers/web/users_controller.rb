# frozen_string_literal: true

class Web::UsersController < ApplicationController
  def new
    @user = User::SignUpForm.new
  end

  def create
    user = User::SignUpForm.new(params[:user])

    if user.save
      f(:success)
      sign_in user

      redirect_to root_path
    else
      f(:error, now: true)
      render :new
    end
  end
end
