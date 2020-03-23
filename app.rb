require 'sinatra'

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb: index
  end

  get '/sign_up' do
    erb: sign_up
  end

  post '/sign_up' do
    # Saves into users DB
    redirect '/user'
  end

  get '/user' do
    erb: user
  end

  get '/create_space' do
    erb: create_space
  end

  post '/create_space' do
    # Saves into spaces DB
    redirect '/user'
  end

  get '/book_space' do
    erb: book
  end

  post '/book_space' do
    # change availability in spaces DB
    redirect '/user'
  end

  run! if app_file == $PROGRAM_NAME
end
