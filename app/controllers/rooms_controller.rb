require 'json'
require 'open-uri'

class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]

  def show
    @booking = Booking.new
    # @room.booking = @booking
  end

  def new
    @room = Room.new
    @room.address = Address.new
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    if @room.save
      address = "#{@room.address.number} #{@room.address.road} #{@room.address.city} #{@room.address.country} #{@room.address.zip_code}"
      result = JSON.load(URI("https://api-adresse.data.gouv.fr/search/?q=#{address.gsub(" ", "+")}"))
      @room.address.coo_gps_long = result["features"][0]["geometry"]["coordinates"][0]
      @room.address.coo_gps_lat = result["features"][0]["geometry"]["coordinates"][1]
      redirect_to root_path(@room)
      sleep(4)
      @room.save
      p "ok"
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:name,
                                 :size,
                                 :category_id,
                                 :description,
                                 :address_id,
                                 :image_url,
                                 :price,
                                 :photo,
                                  address_attributes: [
                                    :number,
                                    :road,
                                    :city,
                                    :country,
                                    :zip_code
                                  ]
                                )
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
