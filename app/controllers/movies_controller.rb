require 'json'
require 'open-uri'

class MoviesController < ApplicationController

  def new
    @movie = Movie.new
  end
  

  
  def create
    get_movie(:title)

    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:success] = "Movie successfully created"
      redirect_to @movie
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def get_movie(search)
    # search = $stdin.gets.chomp
    url = "http://www.omdbapi.com/?s=#{search}&apikey=adf1f2d7"
    user_serialized = URI.open(url).read
    movies_json = JSON.parse(user_serialized)
    @movies = movies_json["Search"].first(5)
  end

  private

  def movie_params
    params.require(:movie).permit(:title)
  end

end
