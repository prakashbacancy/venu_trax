class AttachmentsController < ApplicationController
	 before_action :authenticate_user!

  def index
    @attachments = @attachment.attachments
  end

  def create
    @attachment = Attachment.new(attachments_params)
    if @attachment.save
      flash[:success] = 'Attachment Successfully added'
    else
      flash[:alert] = 'Can not add a Attachment'
    end
    @attachable = @attachment.attachable
  end

  def update
    if attachment.update(attachments_params)
      flash[:success] = 'Attachment updated'
    else
      flash[:alert] = 'Can not update a Attachment'
    end
    redirect_to @attachment.attachable
  end

  def destroy
    if attachment.destroy
      flash[:success] = 'Attachment Successfully Deleted!'
    else
      flash[:alert] = 'Error Occurred While Deleting A Attachment!'
    end
    redirect_to @attachable
  end

  private

  def attachment
    @attachment ||= if params[:id].present?
                Attachment.find(params[:id])
              else
                @attachable.attachments.new
              end
  end

  def attachments_params
    params.require(:attachment).permit(:attachable_type, :attachable_id, :venue_file, :venue_id)
  end
end
