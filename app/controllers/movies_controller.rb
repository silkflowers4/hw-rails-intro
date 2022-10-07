class MoviesController < ApplicationController



    def index
      sort = params[:sort] || session[:sort]

      @movies = Movie.all
      @all_ratings = Movie.all_ratings
      @ratings_to_show = params[:ratings] || session[:ratings] || {}
      if @ratings_to_show == {}
        @ratings_to_show = Hash[@all_ratings.map {|rating| [rating, 1]}]
      end

      if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
        session[:sort] = sort
        session[:ratings] = @ratings_to_show
      end
      @movies = Movie.where(rating: @ratings_to_show.keys).order(sort)
    end
    
  def show
    id = params[:id] 
    @movie = Movie.find(id) 
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end