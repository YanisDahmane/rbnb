class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]

  def show
  end

  def new
    @room = Room.new
    @room.address = Address.new
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    if @room.save
      redirect_to root_path(@room)
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
