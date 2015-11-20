# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'
# =======Import the CSV========
CSV.foreach('db/csv/database_seed.csv', headers: true, header_converters: :symbol) do |row|
  Address.create!(row.to_hash)
end
#=============================

# addresses = Address.all


# =======Change apartments to nil========

# addresses.each do |address|
#  if address.apt_number == " 0"
#     p "#{address.street_number} #{address.street_name} #{address.apt_number}", "#{address.city} #{address.state} #{address.zipcode}"
#     address.apt_number = nil
#     address.save
#     p "#{address.street_number} #{address.street_name} #{address.apt_number}", "#{address.city} #{address.state} #{address.zipcode}"
#   end
# end
#========================================



#==================Information From Zillow==================
# rillow = Rillow.new('X1-ZWz1f0u7tly4nf_55f1z')
# addresses.each do |address|
#   p address.id
#  results = rillow.get_deep_search_results("#{address.street_number} #{address.street_name} #{address.apt_number}", "#{address.city} #{address.state} #{address.zipcode}")
#     # p results['request'][0]["zpid"][0]
#     lat =  results['response'][0]['results'][0]['result'][0]['address'][0]['latitude'][0]
#     long = results['response'][0]['results'][0]['result'][0]['address'][0]['longitude'][0]
#     built = if results['response'][0]['results'][0]['result'][0]['yearBuilt']
#               results['response'][0]['results'][0]['result'][0]['yearBuilt'][0]
#             else
#               '3000'
#             end
#     neighborhood = results['response'][0]['results'][0]['result'][0]['localRealEstate'][0]['region'][0]['name']
#     url = results['response'][0]['results'][0]['result'][0]['links'][0]['homedetails'][0]

#   address.long = long
#   address.lat = lat
#   address.built = built
#   address.neighborhood = neighborhood
#   address.url = url
#   address.save


#   # =======test========
#   # p results
#   # p long
#   # p lat
#   # p built
#   # p neighborhood
#   # p url

# end
#=====================================================================


#==============Walk Score===================
# addresses.each do |address|
#   call= "address=#{address[:street_number]}%#{address[:street_name]}%20#{address[:street_type]}%20#{address[:city]}%20#{address[:state]}%20#{address[:zipcode]}&lat=#{address[:lat]}&lon=#{address[:long]}&wsapikey=b72221d8763203418d081f140357696e"

#   url = URI.parse(URI.encode("http://api.walkscore.com/score?format=json&#{call}"))
#   @json = HTTParty.get(url)
#   response = JSON.parse(@json.body)
#   puts response["walkscore"]
#   puts address
#   address.walkscore = response["walkscore"]
#   address.save
# end
# #=============================================






# =========Fix for no address===========
# addresses = Address.all
# addresses.each do |address|
#   p address.id
#   if address.street_number == nil
#     address.destroy
#   end
# end
#======================================






