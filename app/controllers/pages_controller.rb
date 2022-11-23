class PagesController < ApplicationController
  def home
    @rooms = Room.all
    @categorys = Category.all
  end

  def dashboard
    @rooms = current_user.rooms
    @bookings = current_user.bookings
    @bookings_request = Booking.where(room: current_user.rooms, confirmed: [0,1])
    p @bookings_request
  end
end
