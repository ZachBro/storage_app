class PagesController < ApplicationController
  def new
  end

  def home
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

  def relog
    if %w{ 1 2 3 4 5 6 7 hanging fridge }.include? params[:location]
      @location = params[:location][0].upcase
      @tickets = reorder(unordered)
    elsif params[:location] == "other"
      @tickets = reorder_other(unordered_other)
    else
      redirect_to "/relog?location=1"
    end
  end

  def relog_report
    @array_of_tickets = (report_order_tickets(report_unordered) +
    reorder_other(unordered_other)).in_groups(2).map(&:compact)
  end

  private

    def find_tickets(state)
      Ticket.where(active: true).where("tickets.aasm_state = ?", state).
      preload(details: [:stored_employee]).order(updated_at: :desc).
      paginate(:page => params[:"page#{state}"], :per_page => 50)
    end

    def unordered
      Ticket.where(active:true).where(:"tickets.aasm_state" => ["ST", "RNR"]).
      joins(:details).preload(details: [:stored_employee]).
      where("location like ?", "#{@location}%").distinct.to_a
    end

    def reorder(unordered)
      arr = unordered.map { |a| [a, a.latest_details.location] if
      a.latest_details.location[0] == "#{@location}" }.compact
      sort_and_pop(arr)
    end

    def unordered_other
      Ticket.where(active:true).where(:"tickets.aasm_state" => ["ST", "RNR"]).
      joins(:details).preload(details: [:stored_employee]).where('location !~* ?', '[1234567HF]').distinct.to_a
    end

    def reorder_other(unordered_other)
      arr = unordered_other.map { |a| [a, a.latest_details.location] unless
      ["1", "2", "3", "4", "5", "6", "7", "H", "F"].include? a.latest_details.location[0] }.compact
      sort_and_pop(arr)
    end

    def sort_and_pop(arr)
      arr.sort! { |a, b| a[1] <=> b[1] }
      arr.map(&:shift)
    end

    def report_unordered
      Ticket.where(active:true).where(:"tickets.aasm_state" => ["ST", "RNR"]).
      joins(:details).preload(details: [:stored_employee]).where('location ~* ?', '[1234567HF]').distinct.to_a
    end

    def report_order_tickets(report_unordered)
      arr = report_unordered.map { |a| [a, a.latest_details.location] if
      ["1", "2", "3", "4", "5", "6", "7", "H", "F"].include? a.latest_details.location[0] }.compact
      sort_and_pop(arr)
    end
end
