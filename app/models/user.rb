class User < ApplicationRecord
  # acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_pic, dependent: :destroy

  has_many :notes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :attendees, as: :resourceable, class_name: 'Meetings::Attendee', dependent: :destroy
  has_many :meetings, class_name: 'Meetings::Meeting', dependent: :destroy # meeting as owner
  has_many :venue_contacts, dependent: :destroy

  scope :without_, ->(current_user) { where.not(id: current_user) }
  scope :active, -> { where.not(encrypted_password: '') }
  scope :ordered, -> { order(:full_name) }
  scope :normal_users, -> { where(contact: 0) }
  # validates :email, uniqueness: { case_sensitive: false, message: "enter email has already been taken" }, allow_nil: true

  attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

  enum contact: %w[user venue_contact brand_contact]

  PERMITTED_PARAM = %w[id full_name email phone_no profile_pic].freeze
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

  def all_user_of_related_company
    User.all.active.ordered
  end

  def self.all_active_users
    User.all.active.ordered
  end

  def to_polymorphic
    "User:#{id}"
  end
  
  protected

  def password_required?
    return false if skip_password_validation

    super
  end
end
