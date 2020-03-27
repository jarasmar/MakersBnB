require 'sinatra'
require 'sinatra/flash'

module UserHelper 
  def user_redirect(user)
    if !user
        flash[:notice] = "Please Sign In!"
        redirect '/'
    end
  end
end