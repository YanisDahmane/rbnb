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
    @result[:html] = render_to_string(partial: "pages/room", locals: { room: @room })
    @result[:info] = @room
    @result[:category] = @room.category.name
    @result[:address] = @room.address
    @result[:bookings] = Booking.where(room: @room)
    @result
  end

  def create_all_json
    @rooms = Room.all
    @result = {}
    @rooms.each do |room|
      @room = Room.find(room.id)
      @result[room.id] = {}
      @result[room.id][:html] = render_to_string(partial: "pages/room", locals: { room: @room })
      @result[room.id][:info] = room
      @result[room.id][:category] = room.category.name
      @result[room.id][:address] = room.address
      @result[room.id][:bookings] = Booking.where(room: room)
    end
    @result
  end
end
