class Ticket < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
	enum status: ['Open', 'Inprogress' , 'Closed']
	STATUS =  ['Open', 'Inprogress' , 'Closed']
	PERMITTED_PARAMS = ["id", "title", "description", "status", "assigned_by", "created_at", "updated_at", "created_by"]
  has_many :comments, as: :commentable
end
