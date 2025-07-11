class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # 編集後のリダイレクト先を指定
  def after_update_path_for(resource)
    root_path # たとえばトップページなど、好きな場所に変更可
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
                                        :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date
                                      ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
                                        :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date
                                      ])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
