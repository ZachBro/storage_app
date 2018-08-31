class SearchController < ApplicationController
  def index
    if params[:name].present? && params[:room].present?
      date_start = params[:ds]
      date_end = params[:de]
      search_start = Date.new(*flatten_date_array(date_start, "ds")).
        in_time_zone("Melbourne").at_beginning_of_day
      search_end = Date.new(*flatten_date_array(date_end, "de")).
        in_time_zone("Melbourne").at_end_of_day
      @tickets = Ticket.joins(:details).where("room = ?", "#{params[:room]}").
        where("name like ?", "#{params[:name].upcase}%").
        where(:created_at => search_start..search_end).distinct
    elsif params[:name]
      @tickets = Ticket.where("name like ?", "#{params[:name].upcase}%").where(active: true).or(
                Ticket.where("name like ?", "#{params[:name].upcase}%").where("updated_at > ?", 1.day.ago))
    elsif params[:room]
      @tickets = Ticket.joins(:details).where("room = ?", "#{params[:room]}").where(active: true).distinct.or(
        Ticket.joins(:details).where("room = ?", "#{params[:room]}").where("tickets.updated_at > ?", 1.day.ago).distinct)
    end
  end

  def flatten_date_array(hash, type)
    %w(1 2 3).map { |e| hash["#{type}(#{e}i)"].to_i }
  end
end
