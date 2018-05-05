class ApplicationController < ActionController::Base
  def session_id
    request.session_options[:id]
  end
end
