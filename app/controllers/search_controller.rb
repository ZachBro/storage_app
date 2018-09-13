class SearchController < ApplicationController
  def index
    if params[:ds].present? && params[:de].present?
      search_start = Date.parse(params[:ds]).in_time_zone("Melbourne").at_beginning_of_day
      search_end = Date.parse(params[:de]).in_time_zone("Melbourne").at_end_of_day
      if params[:name].present? && params[:room].present?
        @tickets = Ticket.
          joins(:details).where("room = ?", "#{params[:room]}").
          where("name like ?", "#{params[:name].upcase}%").
          where(:created_at => search_start..search_end).
          preload(details: [:stored_employee, :retrieved_employee]).
          distinct.paginate(:page => params[:page])
      elsif params[:name].present?
        @tickets = Ticket.
          where("name like ?", "#{params[:name].upcase}%").
          where(:created_at => search_start..search_end).
          preload(details: [:stored_employee, :retrieved_employee]).
          paginate(:page => params[:page])
      elsif params[:room].present?
        @tickets = Ticket.
          joins(:details).where("room = ?", "#{params[:room]}").
          where(:created_at => search_start..search_end).
          preload(details: [:stored_employee, :retrieved_employee]).
          distinct.paginate(:page => params[:page])
      end
    end
  end

  def show
    if params[:name].present? && params[:room].present?
      @tickets = Ticket.joins(:details).where("room = ?", "#{params[:room]}").
        where("tickets.name like ?", "#{params[:name].upcase}%").
        where(active: true).distinct.or(
        Ticket.joins(:details).where("room = ?", "#{params[:room]}").
        where("tickets.name like ?", "#{params[:name].upcase}%").
        where("tickets.updated_at > ?", Time.now.in_time_zone("Melbourne").at_beginning_of_day).
        distinct).preload(details: [:stored_employee, :retrieved_employee]).
        paginate(:page => params[:page])
    elsif params[:name].present?
      @tickets = Ticket.where("name like ?", "#{params[:name].upcase}%").
        where(active: true).or(
        Ticket.where("name like ?", "#{params[:name].upcase}%").
        where("updated_at > ?", Time.now.in_time_zone("Melbourne").at_beginning_of_day)).
        preload(details: [:stored_employee, :retrieved_employee]).
        paginate(:page => params[:page])
    elsif params[:room].present?
      @tickets = Ticket.joins(:details).where("room = ?", "#{params[:room]}").
        where(active: true).distinct.or(
        Ticket.joins(:details).where("room = ?", "#{params[:room]}").
        where("tickets.updated_at > ?", Time.now.in_time_zone("Melbourne").at_beginning_of_day).
        distinct).preload(details: [:stored_employee, :retrieved_employee]).
        paginate(:page => params[:page])
    end
    respond_to do |format|
      format.html { redirect_to root_path(params.permit(:room, :name, :page)) }
      format.js
    end
  end
end
