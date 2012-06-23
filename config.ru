require 'app'

$stdout.sync = true

use Rack::ShowExceptions

run App.new