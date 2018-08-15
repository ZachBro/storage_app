class DetailsController < ApplicationController

  def create
    @ticket = Ticket.find(params[:id])
    @ticket.details.build
    redirect_to :back
  end
end
