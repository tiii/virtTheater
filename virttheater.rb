require 'sinatra'
require './models'

CONFIG = ENV.to_hash
CONFIG.merge YAML::load(File.open('./config/environment.yml'))[ENV["RACK_ENV"].to_sym] if ENV["RACK_ENV"] == "development"

module VirtTheater

  class VirtTheaterWebApp < Sinatra::Base
    get '/' do
      haml :index, locals: {env: ENV["RACK_ENV"]}
    end

    get'/auth' do
      haml :auth, locals: {app_id: CONFIG[:app_id], scope: CONFIG[:scope]}
    end

    post '/canvas/' do
      redirect "/auth/facebook?signed_request=#{request.params['signed_request']}&state=canvas"
    end

    get '/auth/:provider/callback' do
      puts request.env.inspect
    end


  end

  class VirtTheaterApi < Sinatra::Base

  end

end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :facebook, CONFIG[:app_id], CONFIG[:app_secret],
            scope: CONFIG[:scope], display: CONFIG[:display]
end