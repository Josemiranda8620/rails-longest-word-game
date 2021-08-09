require 'open-uri'
require 'json'

class GamesController < ApplicationController
    @@letters = []

    def new
        @@letters = []
        (0..9).each do
          letter = [*('A'..'Z')].sample(1)
          @@letters<< letter[0]
        end
        @letters = @@letters
        return @letters
    end
    
    def score
        @score = ""
        params[:word].chars.each do |letter|
            if @@letters.include?(letter.upcase) == false
                @score = "Sorry but #{params[:word]} can\'t be built out of #{@@letters[0]}, #{@@letters[1]}, #{@@letters[2]}, #{@@letters[3]}, #{@@letters[4]}, #{@@letters[5]}, #{@@letters[6]}, #{@@letters[7]}, #{@@letters[8]}, #{@@letters[9]}"
                return @score
            end
        end

        url = "https://wagon-dictionary.herokuapp.com/#{params[:word].upcase}"
        user = JSON.parse(URI.open(url).read)
         
        if user["found"] == true
            @score = "Congratulations #{params[:word]} is a valid English word!"
            
        else
            @score = "Sorry but #{params[:word]} is a not a valid English word..."    
        end
        return @score
    end    

end












