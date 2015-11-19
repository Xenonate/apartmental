class SearchesController < ActionController::Base

  def create
    p "*" * 50
    # loc=XxxGeocoder.geocode('100 Spear St, San Francisco, CA')
    # if loc.success
    #   puts loc.lat
    #   puts loc.lng
    #   puts loc.full_address
    # end
    location = '633 Folsom St SanFrancisco CA 94107'.split(" ")
    coords = Geokit::Geocoders::GoogleGeocoder.geocode('100 Spear St San Francisco CA')
    puts flash[:location] = location
    puts flash[:lat] = coords.lat
    puts flash[:lng] = coords.lng
    redirect_to searches_path
  end

  def index
    puts flash[:location]
    puts flash[:lat]
    puts flash[:lng]
    call= "address=#{flash[:location][0]}%#{flash[:location][1]}%20#{flash[:location][2]}%20#{flash[:location][3]}%20#{flash[:location][4]}%20#{flash[:location][5]}&lat=#{flash[:lat]}&lon=#{flash[:lng]}&wsapikey=b72221d8763203418d081f140357696e"

    puts a = URI.parse(URI.encode('http://api.walkscore.com/score?format=json&address=1119%8th%20Ave%20Seattle%20WA%&lat=47.6085&lon=-122.3295&wsapikey=b72221d8763203418d081f140357696e'))
    url = HTTParty.get(a)
    @response = JSON.parse(url.body)
    puts @response
    render 'search/index'
  end

end


# var latitude = results[0].geometry.location.lat();
# var longitude = results[0].geometry.location.lng();
