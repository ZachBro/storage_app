class PagesController < ApplicationController
  def new
  end

  def current_st
    current_st = Ticket.joins(:details).where("aasm_state = ?", "ST").where(active: true).distinct.to_a
    @current_st = []
    current_st.each do |c|
      if c.latest_details.aasm_state == "ST"
        @current_st.push(c)
      end
    end

    respond_to do |format|
      format.html {redirect_to "/"}
      format.js
    end
  end

  def current_rnr
    current_rnr = Ticket.joins(:details).where("aasm_state = ?", "RNR").where(active: true).distinct.to_a
    @current_rnr = []
    current_rnr.each do |c|
      if c.latest_details.aasm_state == "RNR"
        @current_rnr.push(c)
      end
    end

    respond_to do |format|
      format.html {redirect_to "/"}
      format.js
    end
  end

  def current_lt
    current_lt = Ticket.joins(:details).where("aasm_state = ?", "LT").where(active: true).distinct.to_a
    @current_lt = []
    current_lt.each do |c|
      if c.latest_details.aasm_state == "LT"
        @current_lt.push(c)
      end
    end

    respond_to do |format|
      format.html {redirect_to "/"}
      format.js
    end
  end

  def home
    current_st = Ticket.joins(:details).where("aasm_state = ?", "ST").where(active: true).distinct.to_a
    @current_st = []
    current_st.each do |c|
      if c.latest_details.aasm_state == "ST"
        @current_st.push(c)
      end
    end
  end
end
