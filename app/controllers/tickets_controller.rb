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

  def index
    if params[:temp_number]
      if params[:temp_number].length == 6
        @ticket = Ticket.find_by number: "#{params[:temp_number]}"
        if @ticket
          redirect_to @ticket
        else
          flash[:success] = "Create new ticket"
          redirect_to new_ticket_path(:number => params[:temp_number])
        end
      else
        flash[:danger] = "Please enter a valid ticket number"
        redirect_to "/tickets/"
      end
    end
  end

  def show
  end

  private

    def ticket_params
      params.require(:ticket).permit(:number, :name,
                              details_attributes:
                              [:amount, :location, :search_id,
                              :stored_employee_id, :retrieved_employee_id])
    end

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end
end
