class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in? #Disponible en vistas

  def current_user #Disponible en controladores
    @current_user ||= User.find(session[:user_id]) if session[:user_id] #Si el valor ya existe no lo asigna de nuevo
  end

  def logged_in?
    !!current_user #Se convierte en un booleano
  end
end
