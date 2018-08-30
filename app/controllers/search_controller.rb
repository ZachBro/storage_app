class SearchController < ApplicationController
  def index
    if params[:ticket]
      @ticket = Ticket.find_by number: "#{params[:ticket]}"
    elsif params[:name_date] && params[:date]
      date_var = params[:date]
      search_date = Date.new(*flatten_date_array(date_var)).in_time_zone("Melbourne").at_beginning_of_day
      @tickets = Ticket.where("name like ?", "#{params[:name_date].upcase}%").where("updated_at > ?", search_date).or(
                 Ticket.where("name like ?", "#{params[:name_date].upcase}%").where(active: true))
    elsif params[:name]
      @tickets = Ticket.where("name like ?", "#{params[:name].upcase}%").where(active: true).or(
                Ticket.where("name like ?", "#{params[:name].upcase}%").where("updated_at > ?", 1.day.ago))
    elsif params[:room]
      @ticket = Ticket.joins(:details).where("room = ?", "#{params[:room]}").where(active: true).distinct.or(
        Ticket.joins(:details).where("room = ?", "#{params[:room]}").where("tickets.updated_at > ?", 1.day.ago).distinct)
    end
  end

  def flatten_date_array(hash)
    %w(1 2 3).map { |e| hash["date(#{e}i)"].to_i }
  end
end
