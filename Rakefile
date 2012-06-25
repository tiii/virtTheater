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
    Play.find_or_create_by_title(:title => "Romeo and Juliet").update_attributes(
      :picture => image_helper("http://farm1.staticflickr.com/22/32538682_8558d390ae.jpg"),
      :description => "Shakespeare's tale of passionate love, Prokofiev's intoxicating score and Macmillan's choreography come together to create the ballet classic, Romeo And Juliet.\n\nThe roles of Romeo and Juliet are star ones, a fact reflected keenly in the three pas de deux that mark the lovers' journey from first meeting to consummated love and finally to tragedy in the tomb.\n\nAround Romeo And Juliet, the life of Verona plays out in vivid colour, whether in its bustling marketplace or a grand ball. There are noble families and their feuds, sword fights and harlots, the informality of youthful friendship and the formality of power and wealth."
    )
    #http://farm8.staticflickr.com/7244/7181583501_0e06581100.jpg
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