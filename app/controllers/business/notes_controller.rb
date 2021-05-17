class Business::NotesController < NotesController
  before_action :set_notable, only: %i[new edit destroy]
  before_action :note, only: %i[new edit update]

  private

  def set_notable
    @notable = Business.find(params[:business_id])
  end
end
