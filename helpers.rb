# encoding: UTF-8
module Helpers
  def self.sluggify(string)
    accents = { 
      ['á','à','â','ä','ã'] => 'a',
      ['Ã','Ä','Â','À'] => 'A',
      ['é','è','ê','ë'] => 'e',
      ['Ë','É','È','Ê'] => 'E',
      ['í','ì','î','ï'] => 'i',
      ['Î','Ì'] => 'I',
      ['ó','ò','ô','ö','õ'] => 'o',
      ['Õ','Ö','Ô','Ò','Ó'] => 'O',
      ['ú','ù','û','ü'] => 'u',
      ['Ú','Û','Ù','Ü'] => 'U',
      ['ç'] => 'c', ['Ç'] => 'C',
      ['ñ'] => 'n', ['Ñ'] => 'N'
    }

    accents.each do |ac,rep|
      ac.each do |s|
        string = string.gsub(s, rep)
      end
    end

    string = string.gsub(/[^a-zA-Z0-9 ]/,"")
    string = string.gsub(/[ ]+/," ")    
    string = string.gsub(/ /,"-")
    string = string.downcase
  end
end