class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def not_found
    flash[:alert] = "Запись не существует!"
    redirect_to request.referer || root_path
  end

  def user_not_authorized
    flash[:alert] = "У Вас нет прав для выполнения этого действия!"
    redirect_to request.referer || root_path
  end
end
