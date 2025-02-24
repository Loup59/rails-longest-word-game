require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @response = ''
    url = "https://dictionary.lewagon.com/#{params[:input]}"
    # chercher le mot(params[:input]) dans le dico
    wordapi = URI.parse(url).read
    @word = JSON.parse(wordapi)
    # reponse API
    @grid = params[:input].chars.all? { |char| params[:input].count(char) <= params[:letters].count(char) }
    # decompose le mot en lettre et calcul le nbre de chaq lettre pour comparaison avec grille
    if @grid
      if @word['found']
        @response = "you won #{@word['length']} pt"
      else
        @response = 'not in the dico'
      end
    else
      @response = 'not in the grid'
    end
  end
end
