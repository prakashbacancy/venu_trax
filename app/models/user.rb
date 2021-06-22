class User < ApplicationRecord
  # acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_pic, dependent: :destroy
  validates :profile_pic, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..10.megabytes }

  has_many :notes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :attendees, as: :resourceable, class_name: 'Meetings::Attendee', dependent: :destroy
  has_many :meetings, class_name: 'Meetings::Meeting', dependent: :destroy # meeting as owner
  has_many :venue_contacts, dependent: :destroy

  scope :without_, ->(current_user) { where.not(id: current_user) }
  scope :active, -> { where.not(encrypted_password: '') }
  scope :ordered, -> { order(:full_name) }
  scope :normal_users, -> { where(contact: 0) }
  scope :not_contacts, -> { User.where(contact: 0) }
  # validates :email, uniqueness: { case_sensitive: false, message: "enter email has already been taken" }, allow_nil: true

  attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

  enum contact: %w[user venue_contact brand_contact]

  STATUS = %w[active inactive].freeze
  STATUS_ACTIVE = 'active'.freeze
  STATUS_INACTIVE = 'inactive'.freeze
  STATUS_INVITED = 'invited'.freeze
  PERMITTED_PARAM = %w[id full_name email phone_no profile_pic status time_zone].freeze
  PERMITTED_PASSWORD_PARAM = %w[id current_password password password_confirmation].freeze

  def google_token_expired?
    Time.current > google_token_expired_at rescue true
  end

  def send_login_instructions(current_user)
    InvitationWorker.perform_async(:user_login_instructions, user_id: id, current_user_id: current_user.id)
  end

  def send_account_setup_instructions(current_user)
    token = set_reset_password_token
    InvitationWorker.perform_async(:user_account_setup_instructions, user_id: id, token: token, current_user_id: current_user.id)
  end

  def all_without_contact_user
    User.not_contacts.ordered
  end

  def self.all_active_users
    User.all.active.ordered
  end

  def to_polymorphic
    "User:#{id}"
  end

  def capitalize_status
    status.split('_').collect(&:capitalize).join(' ')
  end

  def active_for_authentication?
    super && account_active?
  end

  def inactive_message
    account_active? ? super : :account_inactive
  end

  def account_active?
    status == User::STATUS_ACTIVE
  end

  def active_support_timezone
    (ActiveSupport::TimeZone[time_zone] || Time.zone) rescue Time.zone
  end
  
  protected

  def password_required?
    return false if skip_password_validation

    super
  end
end
