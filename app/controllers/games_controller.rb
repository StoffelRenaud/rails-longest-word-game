require 'open-uri'

class GamesController < ApplicationController
  def new
    create_grid
  end

  def create_grid
    @grid = []
    (1..12).each do
      @grid << ('A'..'Z').to_a.sample
    end
    @grid
  end

  def score
    @grid = params[:grid]
    @word = params[:word]
    @grid_result = test_grid(@grid.split(" ").sort, @word.upcase.split(//))
    @word_result = test_word(@word)
  end

  def test_grid(grid, word)
    word.all? { |letter| grid.include? (letter) }
    raise
  end

  def test_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    search_word = URI.parse(url).open.read
    result = JSON.parse(search_word)
    result['found']
  end

end
