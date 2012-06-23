require 'sinatra'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  has_many :tickets
end

class Play < ActiveRecord::Base
  has_many :plays
end

class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :play
end

