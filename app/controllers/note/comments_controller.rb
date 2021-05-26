class Note::CommentsController < CommentsController
  before_action :set_module, only: %i[new edit destroy]
  before_action :set_commentable, only: %i[new edit destroy create]
  before_action :comment, only: %i[new edit update]

  def create
    super
    @comments = @commentable.comments
  end

  private

  def set_commentable
    @commentable = Note.find(params[:note_id])
    @partial_name_part = @commentable.class.name.split('::').last.downcase
  end

  def set_module
    @module = if params[:business_id].present?
                Business.find(params[:business_id])
              else
                Venue.find(params[:venue_id])
              end
  end
end
