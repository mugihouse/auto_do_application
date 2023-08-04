class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show]

  def new
    @profile = Profile.new()
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path(current_user), success: 'プロフィールを登録しました'
    else
      flash.now[:danger] = 'プロフィールの作成に失敗しました'
      render :new
    end
  end

  def show; end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:dinner_time, :bedtime, day_of_week_ids: [])
  end
end
