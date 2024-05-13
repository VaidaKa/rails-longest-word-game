require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    @letters.shuffle!
  end

  def score
    @word = (params[:word] || '').upcase
    @letters = params[:letters] ? param[:letters].split : []
    @english_word = english_word?(@word)
  end

  private

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
