class ApiController < ApplicationController
  def rooms
    render json: create_room_json
  end

  def all
    render json: create_all_json
  end

  private

  def create_room_json
    @room = Room.find(params[:id])
    @result = {}
    @result[:info] = @room
    @result[:address] = @room.address
    @result[:bookings] = Booking.where(room: @room)
    @result
  end

  def create_all_json
    @rooms = Room.all
    @result = {}
    @rooms.each do |room|
      @result[room.id] = {}
      @result[room.id][:info] = room
      @result[room.id][:address] = room.address
      @result[room.id][:bookings] = Booking.where(room: room)
    end
    @result
  end
end
