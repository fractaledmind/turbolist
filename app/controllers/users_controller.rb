class UsersController < ApplicationController
  # ----- unauthenticated actions -----
  with_options only: %i[ new create ] do
    skip_before_action :authenticate!
  end

  # GET /users/new
  def new
    @user = User.new
    render layout: "authentication"
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(user: @user)
      redirect_to user_root_path, notice: "Your profile was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
