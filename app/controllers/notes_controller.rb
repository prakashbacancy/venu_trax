class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notes = @note.notes
  end

  def create
    @note = Note.new(notes_params)
    if @note.save
      flash[:success] = 'Note Successfully added'
    else
      flash[:alert] = 'Can not add a Note'
    end
    @notable = @note.notable
    # redirect_to @note.notable
  end

  def update
    if note.update(notes_params)
      flash[:success] = 'Note updated'
    else
      flash[:alert] = 'Can not update a Note'
    end
    redirect_to @note.notable
  end

  def destroy
    if note.destroy
      flash[:success] = 'Note Successfully Deleted!'
    else
      flash[:alert] = 'Error Occurred While Deleting A Note!'
    end
    redirect_to @notable
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
    params.require(:note).permit(:description, :notable_type, :notable_id, :task_to_follow_up).merge(user: current_user)
  end
end
