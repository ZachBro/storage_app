class SearchController < ApplicationController
  def index
    if params[:ds].present? && params[:de].present?
      search_start = Date.parse(params[:ds]).in_time_zone("Melbourne").at_beginning_of_day
      search_end = Date.parse(params[:de]).in_time_zone("Melbourne").at_end_of_day
      if params[:name].present? && params[:room].present?
        @tickets = Ticket.
          includes(details: [:stored_employee, :retrieved_employee]).
          where("room = ?", "#{params[:room]}").references(:details).
          where("tickets.name like ?", "#{params[:name].upcase}%").
          where(:created_at => search_start..search_end).
          distinct.paginate(:page => params[:page])
      elsif params[:name].present?
        @tickets = Ticket.
          includes(details: [:stored_employee, :retrieved_employee]).
          where("name like ?", "#{params[:name].upcase}%").
          where(:created_at => search_start..search_end).
          distinct.paginate(:page => params[:page])
      elsif params[:room].present?
        @tickets = Ticket.
          includes(details: [:stored_employee, :retrieved_employee]).
          where("room = ?", "#{params[:room]}").references(:details).
          where(:created_at => search_start..search_end).
          distinct.paginate(:page => params[:page])
      end
    end
  end

  def show
    if params[:name].present? && params[:room].present?
      @tickets = Ticket.
        includes(details: [:stored_employee, :retrieved_employee]).
        where("room = ?", "#{params[:room]}").references(:details).
        where("tickets.name like ?", "#{params[:name].upcase}%").
        where(active: true).distinct.or(
        Ticket.
        includes(details: [:stored_employee, :retrieved_employee]).
        where("room = ?", "#{params[:room]}").references(:details).
        where("tickets.name like ?", "#{params[:name].upcase}%").
        where("tickets.updated_at > ?", Time.now.in_time_zone("Melbourne").at_beginning_of_day).
        distinct).
        paginate(:page => params[:page])
    elsif params[:name].present?
      @tickets = Ticket.
        includes(details: [:stored_employee, :retrieved_employee]).
        where("name like ?", "#{params[:name].upcase}%").where(active: true).or(
        Ticket.
        includes(details: [:stored_employee, :retrieved_employee]).
        where("name like ?", "#{params[:name].upcase}%").
        where("updated_at > ?", Time.now.in_time_zone("Melbourne").at_beginning_of_day)).
        paginate(:page => params[:page])
    elsif params[:room].present?
      @tickets = Ticket.
        includes(details: [:stored_employee, :retrieved_employee]).
        where("room = ?", "#{params[:room]}").references(:details).
        where(active: true).distinct.or(
        Ticket.
        includes(details: [:stored_employee, :retrieved_employee]).
        where("room = ?", "#{params[:room]}").references(:details).
        where("tickets.updated_at > ?", Time.now.in_time_zone("Melbourne").at_beginning_of_day).
        distinct).
        paginate(:page => params[:page])
    end
    respond_to do |format|
      format.html { redirect_to root_path(params.permit(:room, :name, :page)) }
      format.js
    end
  end
end
