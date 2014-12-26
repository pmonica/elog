class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def after_inactive_sign_up_path_for(resource)
    '/users/sign_in'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :organization_id)
  end
end
