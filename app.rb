# frozen_string_literal: true

require 'sinatra'
require 'sinatra/flash'
require './lib/database_connection_setup.rb'
require './lib/user.rb'
require './lib/space'
require './lib/booking'
require 'mailgun-ruby'
require 'dotenv/load'


class MakersBnB < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  before do
    @user = User.instance
  end

  get '/' do
    @spaces = Space.all
    erb :index
  end

  get '/sign_up' do
    erb :'users/sign_up'
  end

  post '/sign_up' do
    # Saves into users DB (params - Name, email, username password)
    # Update parameter names when decided

    User.create(name: params[:name], email: params[:email], password: params[:password])
    # First, instantiate the Mailgun Client with your API key
    mg_client = Mailgun::Client.new ENV['MAILGUN_API']
    # Define your message parameters
    message_params =  { from: 'makersbnb02@gmail.com',
                        to:   ENV['EMAIL'],
                        subject: 'MakersBnB Signup!',
                        text:    "Thank you #{params[:name]} for signing up to MakersBnB!"
                      }

    # Send your message through the client
    mg_client.send_message ENV['MAILGUN_SANDBOX'], message_params

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
    @spaces = Space.available
    erb :user
  end

  get '/my_bookings/:user_id' do
    @pending = @user.my_bookings(status: 0)
    @accepted = @user.my_bookings(status: 1)
    @declined = @user.my_bookings(status: 2)
    erb :'users/my_bookings'
  end

  get '/my_spaces' do
    @my_spaces = Space.my_spaces(user_id: @user.user_id)
    erb :'users/my_spaces'
  end

  get '/my_spaces/create_space' do
    erb :'spaces/create'
  end

  post '/my_spaces/create_space' do
    # Saves into spaces DB
    # Update parameter names when decided

    # As we are not log_in yet, authenticate the user is registered in DB
    # If user exists, create the new space, if not, throw error
    Flash[:notice] = 'Please log in to create a space' unless !!@user

    Space.create(space_name: params[:space_name], description: params[:description], price: params[:price], user_id: @user.user_id)
    redirect '/my_spaces'
  end

  get '/my_spaces/manage' do
    @pending = @user.my_space_bookings(status: 0)
    @confirmed = @user.my_space_bookings(status: 1)
    @declined = @user.my_space_bookings(status: 2)
    # @cancelled = Booking.my_bookings(status: 3)
    erb :'users/space_management'

    # get booking user, space, and booking for each booking

    # pending will take status = 0, and my user_id. These will be passed to a method which will

    #   take my user_id
    #   find all bookings relating to my user_id

    #   find all pending bookings related to my user_id

    # SELECT *
    # FROM bookings
    # INNER JOIN bookings
    # ON booking_id = bookings.booking_id
    # INNER JOIN spaces
    # ON spaces_id = spaces.spaces_id
    # WHERE spaces.user_id = '#{user_id}';

    # for each booking_id

    #   get booking user, space, and booking for each booking

    # booking user

    # SELECT *
    # FROM users
    # INNER JOIN bookings
    # ON user.id = bookings.user_id
    # WHERE bookings.booking_id = '#{booking_id}';

    #   for each pending booking, have the option to accept or decline

    #   pending
    #     booking 1
    #     bookings 2

    #   confirmed
    #     booking 1
    #     booking 2

    #   declined
    #     booking 1
    #     booking 2

    # spaces = Spaces.find_spaces(user_id)

    #   spaces.each

    #     Booking.find_space_bookings(space_id)

    # end
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
    # find_space gets all the information from a space from the DB with the id
    @space = Space.find_space(space_id: params[:space_id])
    erb :'spaces/book'
  end

  post '/spaces/book_space/:space_id' do
    # change availability in spaces DB
    # As we are not log_in yet, authenticate the user is registered in DB
    # If user exists, create the new space, if not, throw error
    Flash[:notice] = 'Please log in to book a space' unless !!@user

    Booking.create(user_id: @user.user_id, space_id: params[:space_id])
    redirect "/my_bookings/#{@user.user_id}"
  end
  # get '/bookings/:user_id'
  #   Show all bookings that I have made

  #   awaiting confirmation
  #     bookings

  #   future bookings
  #     bookings

  #   past bookings
  #     bookings

  #   bookings = Booking.find_user_bookings(user_id)

  # end

  # get '/myspacebooking/:user_id'

  # get '/hosting/create_space'

  # end

  # get '/hosting/bookings'

  # end

  #   Show all bookings for each of my spaces

  #   take my user_id
  #   find all spaces related to my user_id
  #   find bookings related to each of these space_ids

  #   space 1
  #     booking 1
  #     bookings 2

  #   space 2
  #     booking 1
  #     booking 2

  # spaces = Spaces.find_spaces(user_id)

  #   spaces.each

  #     Booking.find_space_bookings(space_id)

  # end

  run! if app_file == $PROGRAM_NAME
end
