class Ticket < ApplicationRecord
  	default_scope -> { order(created_at: :desc) }
	enum status: ['Open', 'InProgress' , 'Closed']
	STATUS =  ['Open', 'InProgress' , 'Closed']
	PERMITTED_PARAMS = ["id", "title", "description", "status", "assigned_by", "created_at", "updated_at", "created_by"]
end
