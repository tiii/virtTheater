require 'rubygems'
require 'bundler'
# Quick load fix
require './virttheater'
require 'sinatra/activerecord/rake'

namespace :db do
  task :seed do
    #Plays
    Play.find_or_create_by_title(:title => "Hamlet").update_attributes(
      :picture => image_helper("http://farm2.staticflickr.com/1146/5100152411_3eb6b13f9e.jpg"),
      :description => "This latest London theatre production of Shakespeare's most famous tragedy will be in the West End's Wyndhams Theatre next year. Tickets should be booked well in advance due to the interest Jude Law and Kenneth Branagh is likely to induce.\n\nHamlet is set in Denmark and is the story of Prince Hamlet's submersion into madness. After his Uncle Claudius murders his father the King and then marries his mother, Hamlet plans to exact his revenge.\n\nHamlet is a story of murder, madness, lust, revenge, treachery and incest and has consistently been one of Shakespeare's most performed plays. It is also the longest of Shakespeare's plays and one of the most powerful, inciting commentary from all academic arenas.\n\nConcierge Desk is one of London's leading theatre tickets provider with some of the best availability on the web."
    )
  end

  task :redo do
    Rake::Task['db:rollback'].invoke
    Rake::Task['db:migrate'].invoke
  end
end

def image_helper(url)
  require 'open-uri'
  Base64.encode64(open(url, &:read))
end