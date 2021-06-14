class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: %i[show new edit]
  before_action :set_klass, only: %i[show new edit create update]
  before_action :find_dynamic_fields, only: %i[new edit create update]
  before_action :users, only: %i[index create update]

  def create
    link_raw = set_reset_password_token
    user.assign_attributes(user_params)
    user.skip_password_validation = true
    if user.save
      UserMailer.new_user_password_confirmation(user, link_raw).deliver_now
      flash[:success] = 'User Successfully Added!'
      @user = User.new
    else
      flash[:alert] = user.errors.full_messages.join(', ')
    end
  end

  def update
    if user.update(user_params)
      flash[:success] = 'User Successfully Updated!'
      @user = User.new
    else
      flash[:alert] = user.errors.full_messages.join(', ')
    end
  end

  def destroy
    if user.destroy
      flash[:success] = 'User Successfully Deleted!'
    else
      flash[:alert] = user.errors.full_messages.join(', ')
    end
    redirect_to users_path
  end

  private

  def user
    @user ||= if params[:id].present?
                User.find(params[:id])
              else
                User.new
              end
  end

  def user_params
    dynamic_params = Klass.user.fields.pluck(:name)
    params.require(:user).permit(User::PERMITTED_PARAM + dynamic_params)
  end

  def set_reset_password_token
    raw, enc = Devise.token_generator.generate(user.class, :reset_password_token)
    user.reset_password_token   = enc
    user.reset_password_sent_at = Time.now.utc
    raw
  end

  def set_klass
    @klass = Klass.user
  end

  def users
    @users ||= User.normal_users
  end

  def find_dynamic_fields
    fields = @klass.fields.includes(:field_picklist_values)
    @data = {}
    fields.each do |field|
      @data[field.name.to_sym] = field.field_picklist_values.pluck(:value)
    end
  end
end
