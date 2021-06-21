class TicketsController < ApplicationController

  before_action :load_ticket, only: [:destroy, :edit, :update, :update_status, :show]
  before_action :load_tickets, only: [:create, :update, :destroy]

	def index
    @tickets = Ticket.all
  end

  def new
    @ticket = Ticket.new
  end

  def create
  	@ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash[:success] = 'Ticket Successfully Added!'
    else
      flash[:alert] = Ticket.errors.full_messages.join(', ')
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      flash[:success] = 'Ticket Successfully Updated!'
    else
      flash[:alert] = ticket.errors.full_messages.join(', ')
    end
  end

  def update_status
    @ticket.update_column(:status, params[:status])
    flash[:success] = 'Ticket Status Successfully Updated!'
  end

  def destroy
    if @ticket.destroy
      flash[:success] = 'Ticket Successfully Deleted!'
    else
      flash[:alert] = ticket.errors.full_messages.join(', ')
    end
  end

  def show
  end

  private

  def ticket_params
    params.require(:ticket).permit(Ticket::PERMITTED_PARAMS)
  end

  def load_ticket
    @ticket = Ticket.find_by_id(params[:id])
  end

  def load_tickets
    @tickets = Ticket.all
  end
end
