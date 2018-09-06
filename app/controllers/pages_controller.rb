class PagesController < ApplicationController
  def new
  end

  def current_st
    home

    respond_to do |format|
      format.html {redirect_to st_path(params.permit(:pageST))}
      format.js
    end
  end

  def current_rnr
    home_rnr

    respond_to do |format|
      format.html {redirect_to rnr_path(params.permit(:pageRNR))}
      format.js
    end
  end

  def current_lt
    home_lt

    respond_to do |format|
      format.html {redirect_to lt_path(params.permit(:pageLT))}
      format.js
    end
  end

  def home
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
      @match_state = Ticket.joins(:details).where("aasm_state = ?", state).where(active: true).paginate(:page => params[:"page#{state}"]).distinct.to_a
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
