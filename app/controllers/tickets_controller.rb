class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = Ticket.new
    @ticket.details.build
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.save
    redirect_to @ticket
  end

  def show
  end

  private

    def ticket_params
      params.require(:ticket).permit(:number, :name, details_attributes:
                                     [:amount, :location, :search_id, :stored_employee_id])
    end

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end
end
