class SearchController < ApplicationController
  def index
    if params[:search_for_ticket]
      @ticket = Ticket.find_by number: "#{params[:search_for_ticket]}"
    elsif params[:search_for_name]
      @tickets = Ticket.where("name like ?", "#{params[:search_for_name].upcase}%").where(active: true)
    end
  end
end
