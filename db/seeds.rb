# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
p "Resetting database..."
Booking.destroy_all
Room.destroy_all
Category.destroy_all
Address.destroy_all
User.destroy_all
p "Database reset!"
p "Creating users..."
u1 = User.create!(email: "yanis@gmail.com", password: "password")
u2 = User.create!(email: "samuel@gmail.com", password: "password")
u3 = User.create!(email: "johan@gmail.com", password: "password")
p "Users created!"
p "Creating address"
a1 = Address.create!(number: 1, road:"rue de la paix", city:"Paris", country: "France", zip_code: 69000)
a2 = Address.create!(number: 2, road:"rue de la colere", city:"Paris", country: "France", zip_code: 75000)
a3 = Address.create!(number: 3, road:"rue du sex", city:"Paris", country: "France", zip_code: 01000)
p "Address created!"
p "Creating categories"
c1 = Category.create!(name: "Dentiste")
c2 = Category.create!(name: "Medecin")
c3 = Category.create!(name: "Infirmier")
c4 = Category.create!(name: "Psychologue")
c5 = Category.create!(name: "Kinésithérapeute")
Category.create!(name: "Orthophoniste")
Category.create!(name: "Ostéopathe")
Category.create!(name: "Pédicure-podologue")
Category.create!(name: "Sage-femme")
Category.create!(name: "Psychomotricien")
p "Categories created!"
p "Creating rooms"
r1 = Room.create!(name: "Salle 1", size: 4, category_id: c1.id, description: "Salle de dentiste", user_id: u1.id, address_id: a1.id, price: 100, image_url: "https://imgs.search.brave.com/StHfZAw2yEtJ1AIQrVvNrN2qEy78AsGO5VXMXPTWdcA/rs:fit:1200:1200:1/g:ce/aHR0cDovL3d3dy5m/cmFuY29pc2V2b2dl/bGVlci5jb20vd3At/Y29udGVudC91cGxv/YWRzLzIwMjAvMDYv/MjYyLVRlcnZ1ZXJl/bi0xMDctc2NhbGVk/LmpwZw")
r2 = Room.create!(name: "Salle 2", size: 666, category_id: c2.id, description: "Salle de medecin", user_id: u2.id, address_id: a2.id, price: 200, image_url: "https://imgs.search.brave.com/StHfZAw2yEtJ1AIQrVvNrN2qEy78AsGO5VXMXPTWdcA/rs:fit:1200:1200:1/g:ce/aHR0cDovL3d3dy5m/cmFuY29pc2V2b2dl/bGVlci5jb20vd3At/Y29udGVudC91cGxv/YWRzLzIwMjAvMDYv/MjYyLVRlcnZ1ZXJl/bi0xMDctc2NhbGVk/LmpwZw")
r3 = Room.create!(name: "Salle 3", size: 26, category_id: c3.id, description: "Salle d'infirmier", user_id: u3.id, address_id: a3.id, price: 300, image_url: "https://imgs.search.brave.com/StHfZAw2yEtJ1AIQrVvNrN2qEy78AsGO5VXMXPTWdcA/rs:fit:1200:1200:1/g:ce/aHR0cDovL3d3dy5m/cmFuY29pc2V2b2dl/bGVlci5jb20vd3At/Y29udGVudC91cGxv/YWRzLzIwMjAvMDYv/MjYyLVRlcnZ1ZXJl/bi0xMDctc2NhbGVk/LmpwZw")
r4 = Room.create!(name: "Salle 4", size: 66, category_id: c4.id, description: "Salle de psychologue", user_id: u1.id, address_id: a1.id, price: 400, image_url: "https://imgs.search.brave.com/StHfZAw2yEtJ1AIQrVvNrN2qEy78AsGO5VXMXPTWdcA/rs:fit:1200:1200:1/g:ce/aHR0cDovL3d3dy5m/cmFuY29pc2V2b2dl/bGVlci5jb20vd3At/Y29udGVudC91cGxv/YWRzLzIwMjAvMDYv/MjYyLVRlcnZ1ZXJl/bi0xMDctc2NhbGVk/LmpwZw")
r5 = Room.create!(name: "Salle 5", size: 166, category_id: c5.id, description: "Salle de kinésithérapeute", user_id: u2.id, address_id: a2.id, price: 500, image_url: "https://imgs.search.brave.com/StHfZAw2yEtJ1AIQrVvNrN2qEy78AsGO5VXMXPTWdcA/rs:fit:1200:1200:1/g:ce/aHR0cDovL3d3dy5m/cmFuY29pc2V2b2dl/bGVlci5jb20vd3At/Y29udGVudC91cGxv/YWRzLzIwMjAvMDYv/MjYyLVRlcnZ1ZXJl/bi0xMDctc2NhbGVk/LmpwZw")
p "Rooms created!"
Booking.create!(start_date: Date.today, end_date: Date.today + 1, room_id: r1.id, user_id: u2.id)
Booking.create!(start_date: Date.today, end_date: Date.today + 1, room_id: r2.id, user_id: u3.id)
Booking.create!(start_date: Date.today, end_date: Date.today + 1, room_id: r3.id, user_id: u1.id)
Booking.create!(start_date: Date.today, end_date: Date.today + 1, room_id: r4.id, user_id: u2.id)
Booking.create!(start_date: Date.today, end_date: Date.today + 1, room_id: r5.id, user_id: u3.id)
p "Bookings created!"
