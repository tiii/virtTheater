require 'sinatra'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  has_many :tickets

  validates_presence_of :first_name, :last_name, :email
end

class Play < ActiveRecord::Base
  has_many :tickets
  has_many :dates
end

# class Date < ActiveRecord::Base
#   belongs_to :play
# end

# class Ticket < ActiveRecord::Base
#   belongs_to :user
#   belongs_to :date
# end

