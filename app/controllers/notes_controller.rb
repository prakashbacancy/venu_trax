class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notes = @note.notes
  end

  def create
    @note = Note.new(notes_params)
    if @note.save
      flash[:success] = 'Note added'
    else
      flash[:danger] = 'Cant add a Note'
    end
    redirect_to @note.notable
  end

  private

  def note
    @note ||= if params[:id].present?
                Note.find(params[:id])
              else
                @notable.notes.new
              end
  end

  def notes_params
    params.require(:note).permit(:description, :notable_type, :notable_id).merge(user: current_user)
  end
end
