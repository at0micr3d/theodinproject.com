module SessionsHelper
	attr_reader :current_user

  def sign_in(user)
  	cookies.permanent[:login] = user.remember
  	current_user = user
  end

  def sign_out
  	current_user = nil
  	cookies.delete :login
  end

  def logged_in?
  	!!current_user
  end

  private

    def current_user
    	@current_user ||= User.find_by(remember_token: cookies[:login])
    end

    def current_user=(user)
  	  @current_user = user
    end
end
