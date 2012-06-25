require 'sinatra'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  has_many :tickets

  validates_presence_of :first_name, :last_name, :email
end

class Play < ActiveRecord::Base
  has_many :tickets
  has_many :play_dates
end

class PlayDate < ActiveRecord::Base
  belongs_to :play
  has_many :tickets
end

class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :play_date
  belongs_to :ticket
end

