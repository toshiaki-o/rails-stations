class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    # 以下の:name部分は追加したカラム名に変える
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password])
  end

  def after_sign_in_path_for(_resource)
    if current_user.is_admin?
      admin_movies_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  def admin_user!
    redirect_to root_url unless current_user.is_admin?
  end
end
