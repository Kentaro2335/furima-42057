class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
                                        :nickname, :last_name, :first_name,
                                        :last_name_kana, :first_name_kana, :birth_date,
                                        :password, :password_confirmation
                                      ])
  end

  private

  def devise_or_items_index?
    devise_controller? || (controller_name == 'items' && action_name == 'index')
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
