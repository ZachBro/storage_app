class PagesController < ApplicationController
  def new
  end

  def home
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
  end

  def current_st
    respond_to do |format|
      format.html {redirect_to st_path(params.permit(:pageST))}
      format.js
    end

    home_st
  end

  def current_rnr
    respond_to do |format|
      format.html {redirect_to rnr_path(params.permit(:pageRNR))}
      format.js
    end

    home_rnr
  end

  def current_lt

    respond_to do |format|
      format.html {redirect_to lt_path(params.permit(:pageLT))}
      format.js
    end

    home_lt
  end

  def home_st
    @current_st = find_tickets("ST")
  end

  def home_rnr
    @current_rnr = find_tickets("RNR")
  end

  def home_lt
    @current_lt = find_tickets("LT")
  end

  private

    def find_tickets(state)
      @match_state = Ticket.where(active: true).includes(details: [:stored_employee]).where("aasm_state = ?", state).references(:details).paginate(:page => params[:"page#{state}"]).distinct.to_a
      only_details_first_match_state(state, @match_state)
    end

    def only_details_first_match_state(state, match_state)
      details_first_match_state = []
      match_state.each do |f|
        if f.latest_details.aasm_state == state
          details_first_match_state.push(f)
        end
      end
    return details_first_match_state
    end
end
