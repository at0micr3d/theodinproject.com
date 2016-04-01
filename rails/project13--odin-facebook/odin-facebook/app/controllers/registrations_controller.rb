class RegistrationsController < Devise::RegistrationsController

	private
	
	# overwrite devises methods to allow for extra user attributes.
	def sign_up_params
		params.require(:user).permit(:firstname, :lastname, :age, :email, :password, :password_confirmation)
	end

	def account_update_params
		params.require(:user).permit(:firstname, :lastname, :age, :email, :password, :password_confirmation)
	end
end