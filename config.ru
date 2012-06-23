require 'rubygems'
require 'bundler'

Bundler.require(:default)

require './virttheater'

map '/' do
  run VirtTheater::VirtTheaterWebApp
end

map '/api' do
  run VirtTheater::VirtTheaterApi
end

$stdout.sync = true