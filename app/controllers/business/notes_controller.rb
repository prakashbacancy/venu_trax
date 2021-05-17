class Business::NotesController < NotesController
  before_action :set_notable, only: %i[new]
  before_action :note, only: %i[new]

  private

  def set_notable
    @notable = Business.find(params[:business_id])
  end
end
