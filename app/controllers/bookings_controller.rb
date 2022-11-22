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

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :room_id, :user_id)
  end
end
