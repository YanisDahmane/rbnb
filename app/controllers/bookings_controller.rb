class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @room = Room.find(params[:room_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @room = Room.find(params[:room_id])
    @booking.user = current_user
    @booking.room = @room
    if disponible?(@booking)
      @booking.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm
    @booking = Booking.find(params[:booking_id])
    @booking.update(confirmed: 1)
    redirect_to dashboard_path
  end

  def decline
    @booking = Booking.find(params[:booking_id])
    @booking.update(confirmed: 2)
    redirect_to dashboard_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :room_id)
  end

  def disponible?(bookings_attemp)
    @bookings = Booking.where(room_id: params[:room_id])
    @bookings.each do |booking|
      return false if booking.start_date <= bookings_attemp.start_date && booking.end_date >= bookings_attemp.end_date
    end
    true
  end
end
