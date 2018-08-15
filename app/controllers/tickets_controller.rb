class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :new_detail]

  def new
    @ticket = Ticket.new
    @ticket.details.build
  end

  def new_detail
    @new_detail = @ticket.details.build
    redirect_to @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.save
    redirect_to @ticket
  end

  def index
    if params[:ticket_number]
      if params[:ticket_number].to_i.to_s.rjust(6, "0") == params[:ticket_number] &&
         params[:ticket_number].length == 6
        @ticket = Ticket.find_by number: "#{params[:ticket_number]}"
        if @ticket
          redirect_to @ticket
        else
          flash[:success] = "Create new ticket"
          redirect_to new_ticket_path(:number => params[:ticket_number])
        end
      else
        flash[:danger] = "Please enter a valid ticket number"
        redirect_to "/tickets/"
      end
    end
  end

  def show
  end

  def update
    @ticket.update(update_params)
    redirect_to @ticket
  end

  private

    def ticket_params
      params.require(:ticket).permit(:number, :name,
                              details_attributes:
                              [:amount, :location, :room, :s_employee_id,
                              :stored_employee_id, :retrieved_employee_id, :id])
    end

    def update_params
      params.require(:ticket).permit(:id, details_attributes: [:amount, :updated_at, :retrieved_employee_id, :r_employee_id, :id])
    end

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end
end
