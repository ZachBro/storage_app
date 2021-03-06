class TicketsController < ApplicationController
  attr_accessor :number
  before_action :set_ticket, only: [:edit, :show_name, :edit_name, :update, :destroy]

  def new
    @ticket = Ticket.new
    @ticket.new_detail
    redirect_to root_path unless params.has_key?(:number) && params[:number].length == 6
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash[:success] = "Successfully created ticket #{@ticket.number}"
      redirect_to '/'
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
        redirect_to "/"
      end
    end
  end

  def show
    @ticket = Ticket.preload(details: [:stored_employee, :retrieved_employee]).find(params[:id])
  end

  def update
    if params[:ticket][:details_attributes]['0'][:r_employee_id] == "000000" && @ticket.update(sign_out_params)
      flash[:success] = "Successfully signed out ticket #{@ticket.number}"
      redirect_back fallback_location: '/relog'
    elsif @ticket.latest_details.retrieved_employee_id.blank? && @ticket.update(sign_out_params)
      flash[:success] = "Successfully signed out ticket #{@ticket.number}"
      redirect_to '/'
    else
      render :action => "show"
    end
  end

  def edit
    if @ticket.update(update_detail_params)
      flash[:success] = "Successfully updated ticket #{@ticket.number}"
      redirect_to '/'
    else
      render :action => "show"
    end
  end

  def show_name
    unless @ticket.active
      redirect_to @ticket
    end
  end

  def edit_name
    if @ticket.active
      if @ticket.update(edit_name_params)
        flash[:success] = "Successfully updated name for ticket #{@ticket.number}"
        redirect_to @ticket
      else
        render :action => "show_name"
      end
    else
      flash[:danger] = "Please sign ticket in before changing name"
      redirect_to @ticket
    end
  end

  def sign_out_relog
    tickets = Ticket.where(id: params[:ticket_ids])
    tickets.each do |f|
      f.latest_details.update_attributes(:r_employee_id => "000000", :updated_at => Time.now)
      f.update_attributes(:aasm_state => "Inactive", :active => "false")
    end
    redirect_back fallback_location: '/relog'
  end


  private

    def ticket_params
      params.require(:ticket).permit(:number, :name, details_attributes:
                              [:amount, :location, :room, :comment, :aasm_state, :s_employee_id, :id])
    end

    def sign_out_params
      params.require(:ticket).permit(:id, details_attributes:
                              [:updated_at, :room, :r_employee_id, :id])
    end

    def update_detail_params
      params.require(:ticket).permit(details_attributes:
                              [:amount, :location, :room, :comment, :aasm_state, :s_employee_id, :id])
    end

    def edit_name_params
      params.require(:ticket).permit(:id, :name)
    end

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end
end
