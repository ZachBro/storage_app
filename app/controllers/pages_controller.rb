class PagesController < ApplicationController
  def new
  end

  def current_st
    @current_st = find_tickets("ST").paginate(:page => params[:page])

    ajax_request
  end

  def current_rnr
    @current_rnr = find_tickets("RNR").paginate(:page => params[:page])

    ajax_request
  end

  def current_lt
    @current_lt = find_tickets("LT").paginate(:page => params[:page])

    ajax_request
  end

  def home
    @current_st = find_tickets("ST").paginate(:page => params[:page])
  end

  private

    def find_tickets(state)
      match_state = Ticket.joins(:details).where("aasm_state = ?", state).where(active: true).distinct.to_a
      only_details_first_match_state(state, match_state)
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

    def ajax_request
      respond_to do |format|
        format.html {redirect_to "/"}
        format.js
      end
    end
end
