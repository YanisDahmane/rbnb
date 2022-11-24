require 'open-uri'
require 'net/http'
require 'nokogiri'

url = "https://www.bing.com/images/search?q=cabinet+medical&form=HDRSC2&first=1&tsc=ImageHoverTitle&cw=1177&ch=793"

doc = Nokogiri::HTML(URI.open(url))

puts doc.css('img').select { |link| link['src'].nil? == false && link['src'].include?("https://") }.map { |link| link['src'] }.sample
