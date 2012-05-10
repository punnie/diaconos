class MoviesController < ApplicationController
  before_filter :authenticate, except: [:index, :show]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
    end
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(params[:movie])
    @movie.creating_user = current_user

    respond_to do |format|
      if @movie.save
        format.html { redirect_to root_url, notice: 'Movie was successfully added to the poll.' }
        format.json { render json: @movie, status: :created, location: @movie }
      else
        format.html { redirect_to root_url, notice: 'Successfully failed to add movie.' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  # POST /movies/:id/vote/:direction
  # POST /movies/:id/vote/:direction.json
  def vote
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.vote(params[:direction], current_user)
        format.html { redirect_to root_url, notice: 'Voted successfully.' }
        format.json { render json: @movie, status: :updated, location: @movie }
      else
        format.html { redirect_to root_url, notice: 'Successfully failed to vote.' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end
end
