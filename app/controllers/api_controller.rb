class ApiController < ApplicationController

  # Si la demande API est pour une seul room /api/id_room
  def rooms
    render json: create_room_json
  end

  # Si la demande est global /api?params
  def all
    render json: create_all_json
  end

  # Si la demande est sur les categories /api/category
  def category
    render json: category_json
  end

  private

  # Création du json pour les categories
  def category_json
    @result = {}
    @categories = Category.all
    @categories.each do |category|
      @result[category.id] = category.name
    end
    @result
  end

  # Création du json pour une room (avec toutes les données de celle ci)
  def create_room_json
    @room = Room.find(params[:id])
    @result = {}
    @result[:html] = render_to_string(partial: "pages/room", locals: { room: @room })
    @result[:info] = @room

    # getbooked(@room) permet de recuperer toutes les dates de reservations
    @result[:booked] = getbooked(@room)
    @result[:category] = @room.category.name
    @result[:address] = @room.address
    @result[:bookings] = Booking.where(room: @room)
    @result
  end

  # Création du json pour toutes les rooms correspondante aux params
  def create_all_json
    @rooms = Room.all
    @result = {}
    count = 0
    # On parcours toutes les rooms
    @rooms.each do |room|
      # On test si la room correspond aux params
      if testRoom(room)
        # Si oui on l'ajoute au json
        addRoom(room)
      end
    end
    @result
  end

  # Création du json pour une room
  def addRoom(room)
    @result[room.id] = {}
    @result[room.id][:html] = render_to_string(partial: "pages/room", locals: { room: room })
    @result[room.id][:info] = room
    @result[room.id][:category] = room.category.name
    @result[room.id][:address] = room.address
    @result[room.id][:bookings] = Booking.where(room: room)
  end

  # Test si la room correspond aux params
  def testRoom(room)
    return false if params["city"] && params["city"].downcase != room.address.city.downcase
    return false if params["category"] && params["category"] != room.category.name
    return false if params["price_max"] && room.price > params["price_max"].to_i
    return false if params["size_min"] && room.size < params["size_min"].to_i

    # Test de la recherche global
    if params["g"]
      # Céation d'une string avec toutes les valeurs interessante de la room
      fullinfo = (room.name + room.description + room.category.name + room.address.city).downcase!;
      params["g"].split(',').each do |word|
        # Si la string ne contient pas le mot on retourne false
        return false unless fullinfo.include?(word.downcase)
      end
    end
    return true
  end

  # Récupération de toutes les dates de reservations
  def getbooked(room)
    result = []
    room.bookings.each do |booking|
      if booking.confirmed == 1
        booking.start_date.upto(booking.end_date) do |date|
          result << date
        end
      end
    end
    result
  end
end
