class PagesController < ApplicationController
  def home
    @rooms = Room.all
  end

  def dashboard
    @rooms = current_user.rooms
    @bookings = current_user.bookings
    @bookings_request = Booking.where(room: current_user.rooms)
  end
end
