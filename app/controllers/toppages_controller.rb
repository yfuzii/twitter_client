class ToppagesController < ApplicationController
  def home
    @user = current_user if current_user
  end
end
