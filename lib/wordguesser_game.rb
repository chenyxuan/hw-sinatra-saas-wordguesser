class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def word
    @word
  end

  def guesses
    @guesses
  end

  def wrong_guesses
    @wrong_guesses
  end

  def guess(gword)
    if not (gword =~ /[a-zA-Z]/)
      raise ArgumentError
    end
    gword = gword.downcase
    @word.chars do |letter|
      if letter == gword
        if @guesses.include? letter
          return false
        else
          @guesses << letter
          return true 
        end
      end
    end
    if @wrong_guesses.include? gword
      return false
    else
      @wrong_guesses << gword
      return true
    end
  end

  def word_with_guesses
    result = ''
    @word.chars do |letter|
      if @guesses.include? letter
        result << letter
      else 
        result << '-'
      end
    end
    result
  end

  def check_win_or_lose
    if self.word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
