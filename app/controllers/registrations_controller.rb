class RegistrationsController < Devise::RegistrationsController

  private

  # Allowed and required parameters for user sign up
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Allowed and required parameters during user account update
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end