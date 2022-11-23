class BookingsController < ApplicationController
  def index
    # @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = @booking.new(booking_params)
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
    params.require(:booking).permit(:start_date, :end_date, :room_id, :user_id)
  end

  def disponible?
    @bookings = Booking.where(room_id: params[:room_id])
    @bookings.each do |booking|
      return false if booking.start_date <= params[:start_date] && booking.end_date >= params[:end_date]
    end
    true
  end
end
