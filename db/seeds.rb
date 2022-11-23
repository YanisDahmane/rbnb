require 'fake'
require 'json'
require 'open-uri'

@number_creation = 50

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
    return r
  end
    generate()
end

## Seeds

p "Resetting database..."
Booking.destroy_all
Room.destroy_all
Category.destroy_all
Address.destroy_all
User.destroy_all
p "Database reset!"

p "Creating (yanis|samuel|johan) users..."
@u1 = User.create!(email: "yanis@gmail.com", password: "password")
u2 = User.create!(email: "samuel@gmail.com", password: "password")
u3 = User.create!(email: "johan@gmail.com", password: "password")
p "Users created!"

p "Creating #{@number_creation} other users..."
@number_creation.times do
  @g_users << User.create!(email: Faker::Internet.email, password: "password")
end

p "Creating #{@number_creation} address..."
@number_creation.times do
  @g_address << Address.create!(generate)
end

p "Creating #{@all_categories.size} categories..."

@all_categories.each do |category|
  @g_categories << Category.create!(name: category)
end
p "Categories created!"

p "Creating #{@number_creation} rooms"

puts @g_users
puts @g_address
puts @g_categories

@number_creation.times do
  @g_rooms << Room.create!(name: Faker::Lorem.word, size: rand(1..100), category: @g_categories.sample, description: Faker::Lorem.paragraph, user_id: @g_users.sample.id, address_id: @g_address.sample.id, price: rand(1..1000), image_url: Faker::Avatar.image)
end
# Creating template
p "Rooms created!"
(@number_creation * 3).times do
  Booking.create!(room_id: @g_rooms.sample.id, start_date: Date.today, end_date: Date.today + 1, user_id: @g_users.sample.id)
end
p "Rooms created!"
