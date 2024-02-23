class SessionsController < ApplicationController
  # ----- unauthenticated actions -----
  with_options only: %i[ new create ] do
    skip_before_action :authenticate!
  end

  # GET /sessions/new
  def new
    @session = Session.new
    render layout: "authentication"
  end

  # POST /sessions
  def create
    @session = Session.new(session_params)

    if @session.save
      redirect_to @session, notice: "Session was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def session_params
      params.require(:session).permit(:user_id, :user_agent, :ip_address)
    end
end
