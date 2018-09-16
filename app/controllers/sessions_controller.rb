class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].upcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to '/employees'
    else
      flash.now[:danger] = "Incorrect name/password"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to '/'
  end
end
