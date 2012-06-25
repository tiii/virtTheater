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
    set :session_secret, "dhjc|4u8u44cq2e.92ru934i,390c4" if ENV["RACK_ENV"] == "development"

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

      u = User.find_or_create_by_email(graph.email)
      u.first_name = graph.first_name
      u.last_name = graph.last_name
      u.access_token = graph.access_token
      puts u.inspect
      {:success => u.save}.to_json
    end

    get '/auth/logout' do
      session[:oauth][:access_token] = {}
      redirect '/'
    end

    get '/plays' do
      haml :plays, :locals => {:plays => Play.all}
    end

    get '/plays/:id/:title' do
      haml :play, :locals => {:play => Play.find(params[:id])}
    end

    get '/style.css' do
      sass :style
    end

    def logged_in?
      return !@user.nil?
    end
  end

  class VirtTheaterApi < Sinatra::Base

  end

end