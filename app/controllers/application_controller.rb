class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Authenticatable

  before_action :set_application_lists, if: :user_signed_in?

  private

    def set_application_lists
      @application_lists = Current.user.lists.where.not(id: nil).order(:title)
    end
end
