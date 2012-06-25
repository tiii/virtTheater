require 'sinatra'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  has_many :tickets

  validates_presence_of :first_name, :last_name, :email
end

class Play < ActiveRecord::Base
  has_many :tickets
  has_many :play_dates

  def url_title
    require './helpers'
    Helpers.sluggify(title)
  end
end

class PlayDate < ActiveRecord::Base
  belongs_to :play
  has_many :tickets

  def timestamp
    Time.at(playtime)
  end

  def dayname
    timestamp.strftime("%A")
  end

  def datetime
    timestamp.strftime("%d.%m.%Y %H:%M")
  end

  def full_date
    "#{dayname}, #{datetime}"
  end

  def tickets_left
    ticket_count - Ticket.where(:play_date_id => id).sum(:count)
  end

  def max
    (tickets_left >= 10) ? 10 : tickets_left
  end
end

class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :play_date

  validates_presence_of :user, :play_date

  def qr_code
    require './helpers'
    Helpers.qrMarkup(code)
  end
end

