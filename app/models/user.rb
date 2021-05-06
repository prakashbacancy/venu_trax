class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_pic, dependent: :destroy

  scope :without_, ->(current_user) { where.not(id: current_user) }

  PERMITTED_PARAM = %w[id full_name email phone_no profile_pic].freeze
end
