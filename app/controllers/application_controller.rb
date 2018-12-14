class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

  def logged_in_user
    if current_user.nil?
      flash[:danger] = "Please log in."
      redirect_to user_session_url
      # before_action :logged_in_user, only: [:create, :destroy]
    end
  end

  def teacher
    unless current_user.teacher?
      flash[:danger] = "U have no permissions."
      redirect_to root_url
    end
  end

  def activated
    unless current_user.activated?
      flash[:danger] = "Please confirm ur email"
      redirect_to root_url
    end
  end

  def judge_params
    params_judge = "base64_encoded=false&fields=status,language,time&page=4&per_page=2"
  end

end
