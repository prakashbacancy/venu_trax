class Business::CommentsController < CommentsController
  before_action :set_notable, only: %i[new edit destroy]
  before_action :set_commentable, only: %i[new edit destroy]
  before_action :comment, only: %i[new edit update]

  private

  def set_commentable
    @commentable = Note.find(params[:note_id])
  end

  def set_notable
    @notable = Business.find(params[:business_id])
  end
end
