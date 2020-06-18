class CallbacksController < Devise::OmniauthCallbacksController
  def slack
    @user = User.from_omniauth_slack(request.env["omniauth.auth"])

    sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, kind: "Slack") if is_navigational_format?
  end

  def failure
    pp '>>>>>>>>>>>>. CALLBACKSCONTROLLER.SLACK FAILURE'

    redirect_to '/'
  end

#        @user = User.from_omniauth(request.env["omniauth.auth"])
#        sign_in_and_redirect @user
#    end
end
