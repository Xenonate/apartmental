# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'

CSV.foreach('db/csv/apartmentalsf_50.csv', headers: true, header_converters: :symbol) do |row|
  Address.create!(row.to_hash)
end


    # location = '633 Folsom St San_Francisco CA 94107'.split(" ")
    # coords = Geokit::Geocoders::GoogleGeocoder.geocode('100 Spear St San Francisco CA')
    # puts flash[:location] = location
    # puts flash[:lat] = coords.lat
    # puts flash[:lng] = coords.lng
    # redirect_to searches_path


    # call= "address=#{flash[:location][0]}%#{flash[:location][1]}%20#{flash[:location][2]}%20#{flash[:location][3]}%20#{flash[:location][4]}%20#{flash[:location][5]}&lat=#{flash[:lat]}&lon=#{flash[:lng]}&wsapikey=b72221d8763203418d081f140357696e"

    # url = URI.parse(URI.encode("http://api.walkscore.com/score?format=json&#{call}"))
    # @json = HTTParty.get(url)
    # @response = JSON.parse(@json.body)

    # @response["walkscore"]

