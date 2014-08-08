require 'rubygems'
require 'geokit'

lat=-23
lng=-45
latlng= Geokit::LatLng.new(lat,lng)
puts latlng
a=Geokit::Geocoders::GoogleGeocoder.reverse_geocode latlng
puts 'Endereco completo: '+a.full_address
puts 'Pais: '+a.country
