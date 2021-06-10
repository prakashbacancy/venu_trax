class Brand::CommentsController < CommentsController
  before_action :set_notable, only: %i[new edit destroy]
  before_action :set_commentable, only: %i[new edit destroy]
  before_action :comment, only: %i[new edit update]

  private

  def set_commentable
    @commentable = Note.find(params[:note_id])
  end

  def set_notable
    @notable = Brand.find(params[:brand_id])
  end
end
