class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if ((!params.has_key?(:sort))&&(!params.has_key?(:ratings)))
      @redirect_check=true
    end
   @all_ratings=Movie.all_ratings
    @sort=params[:sort] || session[:sort]
    @true_hash = params[:ratings] || session[:ratings]
    @true_ratings=@true_hash ? @true_hash.keys : @all_ratings
    if(@redirect_check)
      redirect_to movies_path(:sort => @sort, :ratings => @true_hash)
    end 
    @true_ratings.each do |x|
      params[x]=true
    end
    @movies = Movie.where(:rating => @true_ratings)
    if @sort
      @movies=@movies.order(params[:sort])
    end
    if @sort
      session[:sort]=@sort
    end
    if @true_ratings
      session[:ratings]=@true_hash
    end 
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
end
