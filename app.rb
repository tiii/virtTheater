require 'sinatra'

class App < Sinatra::Base
#   register Mustache::Sinatra
#   require 'views/layout'

  set :mustache, {
    :views     => 'views/',
    :templates => 'templates/'
  }

  get '/' do
    @title = "Mustache + Sinatra = Wonder"
    dir = Dir.open("pictures")
    dir.inspect
  end

end