class ProfilesController < ApplicationController
  before_action :set_user, only: %i[new]

  def new
    @profile = Profile.new()
  end

  def create

  end

  private

  def set_user
    @user = User.find(current_user.id)
  end
end
