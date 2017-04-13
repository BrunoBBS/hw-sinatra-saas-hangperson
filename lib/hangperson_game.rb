class HangpersonGame

    # add the necessary class methods, attributes, etc. here
    # to make the tests in spec/hangperson_game_spec.rb pass.

    # Get a word from remote "random word" service

    # def initialize()
    # end
    attr_accessor :word, :guesses, :wrong_guesses, :valid

    def initialize(word)
        @word = word
        @guesses = ''
        @wrong_guesses = ''
        @valid = false
    end

    def self.get_random_word
        require 'uri'
        require 'net/http'
        uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
        Net::HTTP.post_form(uri ,{}).body
    end

    def guess(letter)
        if not letter =~ /[a-z]/i then raise ArgumentError end
        letter.downcase!
        if @word.include? letter and not @guesses.include? letter
            @guesses += letter
            @valid = true
        elsif not @word.include? letter and not @wrong_guesses.include? letter
            @wrong_guesses += letter
            @valid = true
        else
            @valid = false
        end
    end

    def word_with_guesses()
        tmp = ''
        @word.each_char do |letter|
            if @guesses.include? letter
                tmp += letter
            else
                tmp += '-'
            end
        end
        return tmp
    end

    def check_win_or_lose()
        if @wrong_guesses.length < 7
            if word_with_guesses.eql? @word
                return :win
            else
                return :play
            end
        else
            return :lose
        end
    end
end
