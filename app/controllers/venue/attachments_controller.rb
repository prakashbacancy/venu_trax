class Venue::AttachmentsController < AttachmentsController
  before_action :set_module, only: %i[new edit destroy]
  before_action :set_attachable, only: %i[new edit destroy create]
  before_action :attachment, only: %i[new edit update]

  def create
    super
    @attchaments = @attachable.attachments
  end

  private

  def set_attachable
    @attachable = Venue.find(params[:venue_id])
  end

  def set_module
    @module = Venue.find(params[:venue_id])
  end
end
