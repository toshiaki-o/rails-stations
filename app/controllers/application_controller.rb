class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

    def configure_permitted_parameters
      #以下の:name部分は追加したカラム名に変える
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password])
    end

    def after_sign_in_path_for(resource)
      movies_path
    end
  
    def after_sign_out_path_for(resource)
      new_user_session_path
    end
end
