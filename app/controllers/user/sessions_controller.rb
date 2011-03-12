class User::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    redirect_to :root
    return false
    clean_up_passwords(build_resource)
    render_with_scope :new
  end
  
  # POST /resource/sign_in
  def create
    redirect_to :root
    return false
    resource = warden.authenticate!(:scope => resource_name, :recall => "new")
    sign_in_and_redirect(resource_name, resource)
  end

end