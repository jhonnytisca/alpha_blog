class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in? #Disponible en vistas

  def current_user #Disponible en controladores
    @current_user ||= User.find(session[:user_id]) if session[:user_id] #Si el valor ya existe no lo asigna de nuevo
  end

  def logged_in?
    !!current_user #Se convierte en un booleano
  end

  def require_user
    unless logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

end
