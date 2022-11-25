require 'faker'
require 'json'
require 'open-uri'

# Parametre pour le nombre de fausse room
@number_creation = 50

# Création d'un tableau avec toutes les descriptions possible
@all_description_tag = %w[Fridge examination table gueridor tensiometer stethoscope thermometer syringe tapis sport sink toilette sauna]
# Création des categories
@all_categories = %w[Dentist Doctor Nurse Psychologist Chiropractor]

# Création de tableau pour chaque objets
@g_users = []
@g_categories = []
@g_address = []
@g_rooms = []

## Utils
def generate()
  name = Faker::Name.name
  # On fait une requette api avec un paramettre aleatoire pour avoir une adresse aléatoire
  result = JSON.load(URI("https://api-adresse.data.gouv.fr/search/?q=#{name}+France"))
  if(result["features"].size > 1)
    # Si on a recupere plus d'une adresse on prend la premiere
    # On recupere les coordonnées et on les mets dans un hash
    r = {}
    r[:number] = result["features"][0]["properties"]["context"].split(",")[0]
    r[:road] = result["features"][0]["properties"]["name"]
    r[:city] = result["features"][0]["properties"]["city"]
    r[:country] = "France"
    r[:zip_code] = result["features"][0]["properties"]["postcode"]
    r[:coo_gps_long] = result["features"][0]["geometry"]["coordinates"][0]
    r[:coo_gps_lat] = result["features"][0]["geometry"]["coordinates"][1]
    return r
  end
  # Si on a pas récuprer d'addresse on relance la fonction
    generate()
end

# Récupération d'une image aléatoire en scrappant
def getRandImage()
  url = "https://www.bing.com/images/search?q=medical%20office%20beautifull&qs=n&form=QBIR&qft=%20filterui%3Aimagesize-custom_1920_1080&sp=-1&ghc=1&pq=medical%20office%20beautifull&sc=0-25&cvid=6816B2E1E95340759C69931957F8573E&ghsh=0&ghacc=0&first=1&tsc=ImageHoverTitle"
  doc = Nokogiri::HTML(URI.open(url))
  img = doc.css('img').select { |link| link['src'].nil? == false && link['src'].include?("https://") }.map { |link| link['src'] }.sample
  # On supprime du lien les parametre de taille d'image pour récupere l'image en taille réelle
  img.gsub!("w=", "")
  img.gsub!("h=", "")
end

# Création d'une fausse description grace au tableau de tag
def getDescription
  result = "My office has at its disposal: \n"
  rand(1..5).times do
    # On ajoute de un à 5 tag aléatoire
    result += "#{@all_description_tag.sample}, "
  end
  result
end

## Seeds

p "Resetting database..."
Booking.destroy_all
Room.destroy_all
Category.destroy_all
Address.destroy_all
User.destroy_all
p "Database reset!"

p "Creating #{@all_categories.size} categories..."

# Création des categories
@all_categories.each do |category|
  @g_categories << Category.create!(name: category)
end
p "Categories created!"

@admin = { yanis: {}, samuel: {}, johan: {} }
@all_rooms = []
# On créait 3 users admin grace au hash @admin
p "[Admin] Admin with template"
@admin.each do |key, value|
  value[:user] = User.create!(email: "#{key}@gmail.com", password: "password")
  value[:address] = Address.create!(generate)

  value[:room] = Room.create!(
    name: Faker::Artist.name,
    size: rand(1..100),
    category: @g_categories.sample,
    description: Faker::Lorem.paragraph,
    user_id: value[:user].id,
    address_id: value[:address].id,
    price: rand(1..1000), image_url: getRandImage
  )
  @all_rooms << value[:room]
end

# Pour tout les admin on leur mets une reservation à leur nom
@admin.each_with_index do |(key, value), index|
  value[:booking] = Booking.create!(user_id: value[:user].id, room_id: @all_rooms[index - 1].id, start_date: Date.today, end_date: Date.today + rand(1..10))
end

p "[Admin] Admin created!"

p "Creating #{@number_creation} other users..."
@number_creation.times do
  # On créait un user avec un faux mail
  @g_users << User.create!(email: Faker::Internet.email, password: "password")
  p "Creating user #{@g_users.size} / #{@number_creation}..."
end

p "Creating #{@number_creation} address..."
@number_creation.times do
  # On créait une adresse pour chaque user grace à la fonction generate
  @g_address << Address.create!(generate)
  p "Creating address #{@g_address.size} / #{@number_creation}..."
end

p "Creating #{@number_creation} rooms"
@g_address.each do
  @g_rooms << Room.create!(
    name: Faker::Artist.name,
    size: rand(1..100),
    # On prend une catégorie aléatoire
    category: @g_categories.sample,
    # On prend un description grace à la fonction
    description: getDescription,
    # On prend un user aléatoire
    user_id: @g_users.sample.id,
    # On prend un address aléatoire
    address_id: @g_address.sample.id,
    price: rand(1..1000),
    # On prend une image aléatoire grace à la fonction
    image_url: getRandImage
  )
  p "Creating room #{@g_rooms.size} / #{@number_creation}..."
end
# Creating template
p "Rooms created!"
@g_rooms.each do
  # On créait une reservation pour chaque room
  Booking.create!(room_id: @g_rooms.sample.id, start_date: Date.today, end_date: Date.today + 1, user_id: @g_users.sample.id)
  p "Creating booking #{@g_rooms.size} / #{@number_creation}..."
end
p "Rooms created!"
