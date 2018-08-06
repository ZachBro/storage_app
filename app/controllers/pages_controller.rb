class PagesController < ApplicationController
  def new
  end

  def home
    @current_tickets = Ticket.where(active: true).to_a
  end
end
