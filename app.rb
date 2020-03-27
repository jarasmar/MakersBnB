
require 'sinatra'
require 'sinatra/flash'
require './lib/database_connection_setup.rb'
require './lib/user.rb'
require './lib/space'
require './lib/booking'
require './helpers/user_helper.rb'

class MakersBnB < Sinatra::Base
  
  before do
    @user = User.instance
  end
  
  enable :sessions, :method_override
  register Sinatra::Flash

  helpers UserHelper

  get '/' do
    @spaces = Space.all
    erb :index
  end

  get '/sign_up' do
    erb :'users/sign_up'
  end

  post '/sign_up' do
    User.create(name: params[:name], email: params[:email], password: params[:password])
    redirect '/sign_in'
  end

  get '/sign_in' do
    erb :'users/sign_in'
  end

  post '/sign_in' do
    User.sign_in(email: params[:email], password: params[:password])
    redirect '/user'
  end

  post '/sign_out' do
    @user.sign_out
    redirect '/'
  end

  get '/user' do
    user_redirect(@user)
    @spaces = Space.available
    erb :user
  end

  get '/my_bookings/:user_id' do
    user_redirect(@user)
    @pending = @user.my_bookings(status: 0)
    @accepted = @user.my_bookings(status: 1)
    @declined = @user.my_bookings(status: 2)
    erb :'users/my_bookings'
  end

  get '/my_spaces' do
    user_redirect(@user)
    @my_spaces = Space.my_spaces(user_id: @user.user_id)
    erb :'users/my_spaces'
  end

  get '/my_spaces/create_space' do
    erb :'spaces/create'
  end

  post '/my_spaces/create_space' do
    user_redirect(@user)
    Space.create(space_name: params[:space_name], description: params[:description], price: params[:price], user_id: @user.user_id)
    redirect '/my_spaces'
  end

  get '/my_spaces/manage' do
    @pending = @user.my_space_bookings(status: 0)
    @confirmed = @user.my_space_bookings(status: 1)
    @declined = @user.my_space_bookings(status: 2)
    erb :'users/space_management'
  end

  post '/my_spaces/manage/:booking_id/accept' do
    Booking.accept(booking_id: params[:booking_id], space_id: params[:space_id])
    redirect '/my_spaces/manage'
  end

  post '/my_spaces/manage/:booking_id/decline' do
    Booking.decline(booking_id: params[:booking_id])
    redirect '/my_spaces/manage'
  end

  get '/spaces/book_space/:space_id' do
    @space = Space.find_space(space_id: params[:space_id])
    erb :'spaces/book'
  end

  post '/spaces/book_space/:space_id' do
    user_redirect(@user)
    Booking.create(user_id: @user.user_id, space_id: params[:space_id])
    redirect "/my_bookings/#{@user.user_id}"
  end

  run! if app_file == $PROGRAM_NAME
end
