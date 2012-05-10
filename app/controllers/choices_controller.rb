class ChoicesController < ApplicationController
  # POST /events/:event_id/choices
  # POST /events/:event_id/choices.json
  def create
    @event = Event.find(params[:event_id])
    @choice = @event.choices.build(params[:choice])

    respond_to do |format|
      if @choice.save
        format.html { redirect_to @event, notice: 'Movie was successfully added.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render controller: "events", action: "index" }
        format.json { render json: @choice.errors, status: :unprocessable_entity }
      end
    end
  end


  # POST /events/:event_id/choices/vote/:direction
  # POST /events/:event_id/choices/vote/:direction.json
  def vote
    @event = Event.find(params[:event_id])
    @choice = @event.choices.find(params[:id])

    respond_to do |format|
      if @choice.vote(params[:direction])
        format.html { redirect_to @event, notice: 'Voted successfully.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render controller: "events", action: "index" }
        format.json { render json: @choice.errors, status: :unprocessable_entity }
      end
    end
  end
end
