class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
end
