class EventsController < ApplicationController
  before_filter :authenticate, except: [:index, :show]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @movie = Movie.new
    @event = Event.new

    @next_event = Event.next
    @previous_event = Event.previous

    @current_month = Date.new(params[:year].to_i, params[:month].to_i, 1) rescue Date.today

    @next_month = (@current_month + 1.month)
    @previous_month = (@current_month - 1.month)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to root_url, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { redirect_to root_url, notice: "That date has already been taken." }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  # POST /events/:id/see/:movie_id
  # POST /events/:id/see/:movie_id.json
  def see
    @event = Event.find(params[:id])
    @movie = Movie.find(params[:movie_id])

    respond_to do |format|
      if @event.see(@movie)
        format.html { redirect_to root_url, notice: 'Here\'s hoping you enjoyed the hat-assery.' }
        format.json { render json: @event, status: :updated, location: @event }
      else
        format.html { redirect_to root_url, notice: 'Successfully failed to watch movie. New hights for stupidity. Einstein would be proud.' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
end
