class SessionsController < ApplicationController
  def new

  end

  def create
    #binding.break
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])

      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:alert] =  "Wrong login information"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy

  end
end