class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:business_id]
      @object = Business.find(params[:business_id])
    elsif params[:venue_id]
      @object = Venue.find(params[:venue_id])
    end
    @notes = @object.notes
  end

  def new
    if params[:business_id]
      @object = Business.find(params[:business_id])
    elsif params[:venue_id]
      @object = Venue.find(params[:venue_id])
    end
    @note = @object.notes.new
  end

  def create
    @note = Note.new(notes_params)
    if @note.save
      flash[:success] = 'Note added'
    else
      flash[:danger] = 'Cant add a Note'
    end
    redirect_to business_path(@note.notable)
  end

  private

  def notes_params
    params.require(:note).permit(:description, :notable_type, :notable_id).merge(user: current_user)
  end
end
