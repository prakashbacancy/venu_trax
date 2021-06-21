class Ticket::CommentsController < CommentsController
  before_action :set_notable, only: %i[new edit destroy]
  before_action :set_commentable, only: %i[new edit destroy create]
  before_action :comment, only: %i[new edit update]

  private

  def set_commentable
    @commentable = Ticket.find(params[:ticket_id])
    @partial_name_part = @commentable.class.to_s.downcase rescue "ticket"
    @comments = @commentable.comments
  end

  def set_notable
    @notable = Ticket.find(params[:ticket_id])
  end
end
