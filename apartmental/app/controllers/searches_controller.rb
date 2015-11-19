class SearchesController < ActionController::Base

  def create
    location = '633 Folsom St San_Francisco CA 94107'.split(" ")
    coords = Geokit::Geocoders::GoogleGeocoder.geocode('100 Spear St San Francisco CA')
    puts flash[:location] = location
    puts flash[:lat] = coords.lat
    puts flash[:lng] = coords.lng
    redirect_to searches_path
  end

  def index
    call= "address=#{flash[:location][0]}%#{flash[:location][1]}%20#{flash[:location][2]}%20#{flash[:location][3]}%20#{flash[:location][4]}%20#{flash[:location][5]}&lat=#{flash[:lat]}&lon=#{flash[:lng]}&wsapikey=b72221d8763203418d081f140357696e"

    url = URI.parse(URI.encode("http://api.walkscore.com/score?format=json&#{call}"))
    @json = HTTParty.get(url)
    @response = JSON.parse(@json.body)
    render 'search/index'
  end

end


# var latitude = results[0].geometry.location.lat();
# var longitude = results[0].geometry.location.lng();
