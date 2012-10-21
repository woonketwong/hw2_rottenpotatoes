class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
       @all_ratings = Movie.get_all_ratings
    if params[:sortWhat] == "title"
       session[:sortWhat] = "title"
       @arg2 = "title"
       @arg1 = Array.new
       if session[:sortKeys] != nil
          session[:sortKeys].each { |key, value|
          if value == true
             @arg1 << key 
          end
          }
       end
       @movies = Movie.find(:all, :conditions => {:rating => @arg1}, :order => @arg2)
       @colorClass1 = "hilite"
       @checked = session[:sortKeys]
       params[:sortWhat] = nil
    elsif params[:sortWhat] == "release_date"
       session[:sortWhat] = "release_date"
       @arg2 = "release_date"
       @arg1 = Array.new
       if session[:sortKeys] != nil
          session[:sortKeys].each { |key, value|
          if value == true
             @arg1 << key 
          end
          }
       end
       @movies = Movie.find(:all, :conditions => {:rating => @arg1}, :order => @arg2)
       @colorClass2 = "hilite"
       @checked = session[:sortKeys]
       params[:sortWhat] = nil
    elsif session[:sortWhat] == "title"
       session.delete(:sortWhat)
       @arg2 = "title"
       @arg1 = Array.new
       if session[:sortKeys] != nil
          session[:sortKeys].each { |key, value|
          if value == true
             @arg1 << key 
          end
          }
       end
       @movies = Movie.find(:all, :conditions => {:rating => @arg1}, :order => @arg2)
       @colorClass1 = "hilite"
       @checked = session[:sortKeys]
       params[:sortWhat] = nil
    elsif session[:sortWhat] == "release_date"
       session.delete(:sortWhat)
       @arg2 = "release_date"
       @arg1 = Array.new
       if session[:sortKeys] != nil
          session[:sortKeys].each { |key, value|
          if value == true
             @arg1 << key 
          end
          }
       end
       @movies = Movie.find(:all, :conditions => {:rating => @arg1}, :order => @arg2)
       @colorClass2 = "hilite"
       @checked = session[:sortKeys]
       params[:sortWhat] = nil
    elsif params[:commit] == nil
       @checked = Hash.new
       @all_ratings.each { |key|
          @checked[key] = true
       }
       session[:sortKeys] = @checked
       @movies = Movie.all
    elsif params[:commit] == "backToMovieList"
       @arg2 = ""
       @arg1 = Array.new
       if session[:sortKeys] != nil
          session[:sortKeys].each { |key, value|
          if value == true
             @arg1 << key 
          end
          }
       end
       @movies = Movie.find(:all, :conditions => {:rating => @arg1}, :order => @arg2)
       @checked = session[:sortKeys]
    else
       @checked = Hash.new
       @all_ratings.each { |key|
          if params[:ratings].has_key?(key)
             @checked[key] = true
          else
             @checked[key] = false
          end
       }
       session[:sortKeys] = @checked 
       @arg1 = params[:ratings].keys
       @args = nil
       @movies = Movie.find(:all, :conditions => {:rating => @arg1}, :order => @arg2)
    end
    
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
