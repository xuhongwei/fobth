class AuthenticationsController < Devise::OmniauthCallbacksController
  prepend_before_filter :require_no_authentication

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
 
    if @user && @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to "/login",:alert => t("devise.failure.existing_email")
    end
  end

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user && @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user,:event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to "/",:alert => t("devise.failure.existing_email")
    end
  end

  def twitter
    auth = env["omniauth.auth"]
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"],current_user)

    if @user && @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect @user,:event => :authentication
    else
      session["devise.twitter_uid"] = request.env["omniauth.auth"]
      redirect_to "/login",:alert => t("devise.failure.existing_email")
    end
  end

  def failure
    redirect_to "/"
  end
end
