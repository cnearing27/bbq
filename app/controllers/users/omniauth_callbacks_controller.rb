class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    authenticate("GitHub")
  end

  def google_oauth2
    authenticate("Google")
  end

  def authenticate(service_name)
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: service_name)
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t('devise.omniauth_callbacks.failed', kind: service_name)

      redirect_to new_user_session_path
    end
  end
end

