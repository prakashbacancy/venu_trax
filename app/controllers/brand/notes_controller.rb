class Brand::NotesController < NotesController
  before_action :set_notable, only: %i[new edit destroy]
  before_action :note, only: %i[new edit update]

  private

  def set_notable
    @notable = Brand.find(params[:brand_id])
  end
end
