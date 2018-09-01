class SearchController < ApplicationController
  def index
    if params[:name].present? && params[:room].present?
      search_start = Date.parse(params[:ds]).in_time_zone("Melbourne").at_beginning_of_day
      search_end = Date.parse(params[:de]).in_time_zone("Melbourne").at_end_of_day
      @tickets = Ticket.joins(:details).where("room = ?", "#{params[:room]}").
        where("name like ?", "#{params[:name].upcase}%").
        where(:created_at => search_start..search_end).distinct
    elsif params[:name].present?
      @tickets = Ticket.where("name like ?", "#{params[:name].upcase}%").where(active: true).or(
                 Ticket.where("name like ?", "#{params[:name].upcase}%").where("updated_at > ?", 1.day.ago))
    elsif params[:room].present?
      @tickets = Ticket.joins(:details).where("room = ?", "#{params[:room]}").where(active: true).distinct.or(
                 Ticket.joins(:details).where("room = ?", "#{params[:room]}").where("tickets.updated_at > ?", 1.day.ago).distinct)
    end
  end
end
