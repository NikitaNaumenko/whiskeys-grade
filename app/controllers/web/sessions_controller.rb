# frozen_string_literal: true

class Web::SessionsController < Web::ApplicationController
  def new
    redirect_to root_path if signed_in?

    @sign_in_form = User::SignInForm.new
  end

  def create
    @sign_in_form = User::SignInForm.new(params[:user_sign_in_form])
    user = @sign_in_form.user

    if @sign_in_form.valid?
      sign_in(user)
      f(:success)

      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
