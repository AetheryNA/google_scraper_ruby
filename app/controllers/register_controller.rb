# frozen_string_literal: true

class RegisterController < ApplicationController
  layout 'auth'

  def index
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, Notice: 'Successfully created Account'
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
