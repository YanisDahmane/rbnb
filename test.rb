require 'Faker'
require 'JSON'
require 'open-uri'

@all = []

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

10.times do
  p generate()
end

puts @all
