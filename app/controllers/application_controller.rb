class ApplicationController < ActionController::Base
  protect_from_forgery

    def render(*args)
  	args.first[:layout] = false if request.xhr? and args.first[:layout].nil?
    super
  end

#  layout :layout
#
#  private
#
#  def layout
#    # only turn it off for login pages:
#    is_a?(Devise::SessionsController) ? false : "application"
#    # or turn layout off for every devise controller:
#    devise_controller? && "application"
#
#  end

  
  
end
