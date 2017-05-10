class SessionsController < ApplicationController
  # this class is not useful yet. Just to get token
  def osmSession
    raise env['omniauth.auth']
  end
  
  def yelpSession
    raise env['omniauth.auth']
  end

end
