require 'faker'
require 'json'
require 'open-uri'

@number_creation = 50

@all_description_tag = %w[Fridge examination table gueridor tensiometer stethoscope thermometer syringe tapis sport sink toilette sauna]
@all_categories = %w[Dentist Doctor Nurse Psychologist Chiropractor]

@g_users = []
@g_categories = []
@g_address = []
@g_rooms = []


## Utils
def generate()
  name = Faker::Name.name
  result = JSON.load(URI("https://api-adresse.data.gouv.fr/search/?q=#{name}+France"))
  if(result["features"].size > 1)
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
    generate()
end

def getRandImage()
  url = "https://www.bing.com/images/search?sp=-1&ghc=1&pq=cabinet+medical+jolie&sc=10-21&cvid=B513604FEC5E43928AEDF3A00547B903&ghsh=0&ghacc=0&tsc=ImageHoverTitle&cw=1440&ch=793&q=cabinet+medical+jolie&qft=+filterui:imagesize-custom_1920_1080&form=IRFLTR&first=1"
  doc = Nokogiri::HTML(URI.open(url))
  img = doc.css('img').select { |link| link['src'].nil? == false && link['src'].include?("https://") }.map { |link| link['src'] }.sample
  img.gsub!("w=", "")
  img.gsub!("h=", "")
end

def getDescription
  result = "My office has at its disposal: \n"
  rand(1..5).times do
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

@all_categories.each do |category|
  @g_categories << Category.create!(name: category)
end
p "Categories created!"

@admin = { yanis: {}, samuel: {}, johan: {} }
@all_rooms = []
p "[Admin] Admin with template"
@admin.each do |key, value|
  value[:user] = User.create!(email: "#{key}@gmail.com", password: "password")
  value[:address] = Address.create!(generate)

  value[:room] = Room.create!(name: Faker::Artist.name, size: rand(1..100), category: @g_categories.sample,
                           description: Faker::Lorem.paragraph, user_id: value[:user].id, address_id: value[:address].id,
                           price: rand(1..1000), image_url: getRandImage
  )
  @all_rooms << value[:room]
end

@admin.each_with_index do |(key, value), index|
  value[:booking] = Booking.create!(user_id: value[:user].id, room_id: @all_rooms[index - 1].id, start_date: Date.today, end_date: Date.today + rand(1..10))
end

p "[Admin] Admin created!"


p "Creating #{@number_creation} other users..."
@number_creation.times do
  @g_users << User.create!(email: Faker::Internet.email, password: "password")
  p "Creating user #{@g_users.size} / #{@number_creation}..."
end

p "Creating #{@number_creation} address..."
@number_creation.times do
  @g_address << Address.create!(generate)
  p "Creating address #{@g_address.size} / #{@number_creation}..."
end

p "Creating #{@number_creation} rooms"
@g_address.each do
  @g_rooms << Room.create!(
    name: Faker::Artist.name,
    size: rand(1..100),
    category: @g_categories.sample,
    description: getDescription,
    user_id: @g_users.sample.id,
    address_id: @g_address.sample.id,
    price: rand(1..1000),
    image_url: getRandImage
  )
  p "Creating room #{@g_rooms.size} / #{@number_creation}..."
end
# Creating template
p "Rooms created!"
@g_rooms.each do
  Booking.create!(room_id: @g_rooms.sample.id, start_date: Date.today, end_date: Date.today + 1, user_id: @g_users.sample.id)
  p "Creating booking #{@g_rooms.size} / #{@number_creation}..."
end
p "Rooms created!"
