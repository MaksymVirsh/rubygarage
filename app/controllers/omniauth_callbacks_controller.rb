class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    sign_in_and_redirect @user, event: :authentication if @user.persisted?
  end
end
