class TicketsController < ApplicationController
  attr_accessor :number
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = Ticket.new
    @ticket.details.build
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to @ticket
    else
      render :action => "new"
    end
  end

  def index
    if params[:ticket_number]
      if params[:ticket_number].to_i.to_s.rjust(6, "0") == params[:ticket_number] &&
         params[:ticket_number].length == 6
        @ticket = Ticket.find_by number: "#{params[:ticket_number]}"
        if @ticket
          redirect_to @ticket
        else
          redirect_to new_ticket_path(:number => params[:ticket_number])
        end
      else
        flash[:danger] = "Please enter a valid ticket number (6 digit number)"
        redirect_to "/tickets/"
      end
    end
  end

  def show
  end

  def update
    if @ticket.update(sign_out_params)
      redirect_to @ticket
    else
      render :action => "show"
    end
  end

  def edit
    if @ticket.update(update_detail_params)
      redirect_to @ticket
    else
      render :action => "show"
    end
  end

  private

    def ticket_params
      params.require(:ticket).permit(:number, :name,
                              details_attributes:
                              [:amount, :location, :room, :s_employee_id, :id])
    end

    def sign_out_params
      params.require(:ticket).permit(:id, details_attributes:
                              [:updated_at, :r_employee_id, :id])
    end

    def update_detail_params
      params.require(:ticket).permit(details_attributes:
                              [:amount, :location, :room, :s_employee_id, :id])
    end

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end
end
