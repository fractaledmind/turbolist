module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate!
    helper_method :user_signed_in?
  end

	def sign_in(user:)
    session = user.sessions.create!(
      user_agent: request.user_agent,
      ip_address: request.ip
    )
    Current.session = session
    cookies.signed.permanent[Session::COOKIE_KEY] = {
      value: session.id,
      httponly: true,
      secure: !Rails.env.development?
    }
    true
  end

  def authenticate
    return true if Current.session

    if session = Session.find_by(id: cookies.signed[Session::COOKIE_KEY])
      Current.session = session
      return true
    end

    false
  end

  def authenticate!
    return true if authenticate

    redirect_to new_session_path
  end

  def user_signed_in?
    Current.user.present?
  end
end
