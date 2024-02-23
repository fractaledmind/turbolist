class SessionsController < ApplicationController
  # ----- unauthenticated actions -----
  with_options only: %i[ new create ] do
    skip_before_action :authenticate!
  end

  # GET /sessions/new
  def new
    @user = User.new
    render layout: "authentication"
  end

  # POST /sessions
  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      sign_in(user:)

      redirect_to user_root_path, notice: "Signed in successfully"
    else
      redirect_to sign_in_path(email_hint: params[:email]), alert: "That email or password is incorrect"
    end
  end
end
