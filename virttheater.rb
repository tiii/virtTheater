require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    #:dbfile  => ":memory:"
    #:database  => ":memory:"
    :database  => "./db/#{ENV["RACK_ENV"]}.db"
)

require './models'
require './config/config'

module VirtTheater

  class VirtTheaterWebApp < Sinatra::Base

    enable :sessions
    set :session_secret, "My session secret" if ENV["RACK_ENV"] == "production"

    before do
      session[:oauth] ||= {}
      @user = User.find_by_access_token(session[:oauth][:access_token])
    end

    get '/' do
      haml :index, locals: {env: ENV["RACK_ENV"]}
    end

    get'/auth' do
      haml :auth, locals: {app_id: CONFIG["app_id"], scope: CONFIG["scope"]}
    end

    get '/auth/facebook/callback' do
      session[:oauth][:access_token] = params[:accessToken] #request.cookies["fbsr_#{CONFIG["app_id"]}"]
      graph = FbGraph::User.fetch('me', :access_token => params[:accessToken])

      user = User.find_or_create_by_email(graph.email)
      user.first_name = graph.first_name
      user.last_name = graph.last_name
      user.access_token = graph.access_token

      {:success => user.save}.to_json
    end

    get '/auth/logout' do
      session[:oauth][:access_token] = {}
    end

    def logged_in?
      return (!@user.nil?)
    end
  end

  class VirtTheaterApi < Sinatra::Base

  end

end