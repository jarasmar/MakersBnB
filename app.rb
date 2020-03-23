require 'sinatra'

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    "Hello World!"
  end

  run! if app_file == $PROGRAM_NAME
end
