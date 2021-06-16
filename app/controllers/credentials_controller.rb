class CredentialsController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: %i[edit update]

  def update
    if user.valid_password?(user_params[:current_password])
      if user.reset_password(user_params[:password], user_params[:password_confirmation])
        sign_in(user, bypass: true) if current_user == user
        flash[:notice] = 'Password Changed Successfully!'
      else
        flash[:alert] = user.errors.full_messages&.first
      end
    else
      @user.errors[:base] << 'You have entered wrong current password!'
      flash[:alert] = 'You have entered wrong current password!'
    end
    # redirect_to request.referrer
  end

  private

  def user
    @user ||= User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(User::PERMITTED_PASSWORD_PARAM)
  end
end
