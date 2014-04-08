class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
    def current_or_guest_user()
      current_user || User.find_by_role(User::ROLES.fetch(:guest))
    end

    def current_dictionary()
      current_or_guest_user.dictionary
    end
end
