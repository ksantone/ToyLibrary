class ApplicationController < ActionController::Base

	before_action :configure_commited_parameters, if: :devise_controller?

	add_flash_types :danger, :info, :warning, :success

	protected

	def configure_commited_parameters
		devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :remember_me, :account_img) }
		devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :remember_me, :about, :account_img) }
	end

end
