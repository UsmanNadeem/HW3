# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    @all_ratings = Movie.all_ratings

    session[:sort_by] = Hash.new unless session[:sort_by] != nil
    session[:sort_by] = {params[:sort_by] => "hilite"}  unless params[:sort_by] == nil

    if params[:ratings] == nil && session[:ratings] == nil
      session[:ratings]=Hash.new
      @all_ratings.each { |key| session[:ratings][key] = "1" }
    elsif params[:ratings] != nil
      session[:ratings] = params[:ratings]
    end

    @movies = Movie.find_all_by_rating session[:ratings].keys, :order => session[:sort_by].keys
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
