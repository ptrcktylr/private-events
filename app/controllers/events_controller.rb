class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :add_attendee, :remove_attendee]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    if current_user
      @event = current_user.events.build
    else
      flash[:danger] = "Please log in to create an event!"
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(event_params)
    @event.attendees << current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_attendee
    if @event.attendees.include?(current_user)
      flash.alert = "You're already attending this event!"
      redirect_to event_path(@event)
    else
      @event.attendees << current_user
      flash.notice = "Attended Event!"
      redirect_to event_path(@event)
    end
  end

  def remove_attendee
    if @event.attendees.include?(current_user)
      if @event.creator == current_user
        redirect_to event_path(@event), flash: { alert: "This is your event! You have to attend!"}
      else
        @event.attendees.delete(current_user)
        flash.notice = "Unattended Event!"
        redirect_to event_path(@event)
      end
    else
      flash.alert = "You're not attending this event!"
      redirect_to event_path(@event)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :location, :start_time, :end_time)
    end
end
