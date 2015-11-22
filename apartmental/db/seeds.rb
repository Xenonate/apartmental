# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'
# =======Import the CSV========
CSV.foreach('db/csv/database_export_112115.csv', headers: true, header_converters: :symbol) do |row|
  Address.create!(row.to_hash)
  # p row
end
# =============================

addresses = Address.all
# address = Address.find(274)

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


# 44,240, 272,431
#125, 372 - change to Broadway Ave

# brian api = X1-ZWz1f0unluukgb_5gnlr
# nathan api =  X1-ZWz1f0u7tly4nf_55f1z

#==================Information From Zillow==================
# rillow = Rillow.new('X1-ZWz1f0unluukgb_5gnlr')
# addresses.each do |address|
#   p address.id
#   p "#{address.street_number} #{address.street_name} #{address.street_type} ", "#{address.city} #{address.state} #{address.zipcode}"
#  results = rillow.get_deep_search_results("#{address.street_number} #{address.street_name} #{address.apt_number}", "#{address.city} #{address.state} #{address.zipcode}")
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
#   address.listing_url = url
#   address.save


#   # =======test========
#   p results
#   # p long
#   # p lat
#   # p built
#   # p neighborhood
#   # p url

# end
#=====================================================================


#==============Walk Score===================
# addresses.each do |address|
#   call= "address=#{address[:street_number]}%#{address[:street_name].delete(" ")}%20#{address[:street_type].delete(" ")}%20#{address[:city].delete(" ")}%20#{address[:state]}%20#{address[:zipcode]}&lat=#{address[:lat]}&lon=#{address[:long]}&wsapikey=b72221d8763203418d081f140357696e"

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

# =========Add crimerate===========
# require_relative 'html_whitespace_cleaner'
# require 'nokogiri'
# require 'open-uri'
# addresses = Address.all
# addresses.each do |address|
#   url = "https://www.walkscore.com/score/#{address.street_number}-#{address.street_name.delete(" ")}-#{address.street_type.delete(" ")}-#{address.city.delete(" ")}-#{address.state}-#{address.zipcode}"
#   html = File.read(open(url))
#   clean_html = HTMLWhitespaceCleaner.clean(html)
#   nokogiri_document = Nokogiri.parse(clean_html)
#   html_node = nokogiri_document.children.last
#   html_node.css('.letter-grade')
#   # crimerate = if html_node.css('.letter-grade') != []
#   address.update_attributes(crime_rate: (html_node.css('.letter-grade').first ? html_node.css('.letter-grade').first.text.delete(" ") : "B"))
# end
#======================================
# require_relative 'html_whitespace_cleaner'
# html = File.read(open("http://www.zillow.com/homedetails/592-39th-Ave-San-Francisco-CA-94121/2100661300_zpid/"))#open will turn a website into a file and the read will turn the file into a string.

# clean_html = HTMLWhitespaceCleaner.clean(html)
# nokogiri_document = Nokogiri.parse(clean_html)
# p html_node = nokogiri_document.children.last
# p nokogiri_document.css(".zsg-content-component")[1].text

# p nokogiri_document.css(".zsg-content-component")[1].inner_html

