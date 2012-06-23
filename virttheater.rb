require 'sinatra'
require './models'

CONFIG = YAML::load(File.open('./config/environment.yml'))[ENV["RACK_ENV"].to_sym]

module VirtTheater

  class VirtTheaterWebApp < Sinatra::Base
    get '/' do
      haml :index, locals: {env: Sinatra.env}
    end

    get'/auth' do
      haml :auth, locals: {app_id: CONFIG[:auth][:app_id], scope: CONFIG[:auth][:scope]}
    end
  end

  class VirtTheaterApi < Sinatra::Base

  end

end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :facebook, CONFIG[:auth][:app_id], CONFIG[:auth][:app_secret],
            scope: CONFIG[:auth][:scope], display: CONFIG[:auth][:display]
end