keys = ["app_id","app_secret","scope","display"]

vals = YAML::load(File.open('./config/environment.yml'))[ENV["RACK_ENV"].to_sym] if ENV["RACK_ENV"] == "development"

CONFIG = {}
keys.each do |key|
  CONFIG[key] = (ENV["RACK_ENV"] == "development") ? vals[key] : ENV[key]
end