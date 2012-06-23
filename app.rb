require 'sinatra'

get '/' do
  dir = Dir.open("pictures")
  dir.inspect
end