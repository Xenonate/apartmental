class SearchesController < ActionController::Base

  def create

    @addresses = Address.where(city: search_params[:search_city], bedrooms: search_params[:search_bedroom]).where('price < ?', search_params[:search_price].to_i)

    @long_lat_link = []
    @addresses.each do |address|
      @long_lat_link << [[address.long.to_f, address.lat.to_f], address.listing_url]
    end
   @length_of_stay = search_params[:search_period] == nil ? search_params[:search_period].to_i : 1
# /////////////////////////////////////////////////////////////////////////////
    # p @addresses
    # address = @addresses[4]
    # p address
    # p address.id
    # p address.price.to_i
    # p "average_price"
    # p @average_price = address.rental_average(@length_of_stay)
    # p @crime_rate = address.crime_rate
    # p coords = Geokit::Geocoders::GoogleGeocoder.geocode(search_params[:input_address])
    # call = "mode=#{search_params[:input_mode]}&origin=#{address.lat},#{address.long}&destination=#{coords.lat},#{coords.lng}"
    # url = URI.parse(URI.encode("http://api2.walkscore.com/api/v1/traveltime/json?wsapikey=b72221d8763203418d081f140357696e&#{call}"))
    # json = HTTParty.get(url)
    # response = JSON.parse(json.body)git
    # p "*" * 50
    # p @commute_time = response#["response"]["results"][0]["travel_times"][0]["seconds"] #in mins

    # p @walkscore = address.walkscore

#     @price_range = (@max_price-@min_price)

#     @commute_time_range = (@max_time - @min_time)
#     @actual_commute_time = WALKSCORE_COMMUTE_TIME_API(INPUT_WORKING_ADDRESS)
# # /////////////////////////////////////////////////////////////////////////////////
#     get_weight(@price_weight, params[:price_weight])
#     get_weight(@walkscore_weight, params[:walkscore_weight])
#     get_weight(@crime_weight, params[:crime_weight])
#     get_weight(@commutescore_weight, params[:commutescore])


    # if params[:price_weight]
    #   @price_weight = params[:price_weight]
    # else
    #   @price_weight = 0.25
    # end

    # if params[:walkscore_weight]
    #   @walkscore_weight = params[:walkscore_weight]
    # else
    #   @walkscore_weight = 0.25
    # end

    # if params[:crime_weight]
    #   @crime_weight = params[:crime_weight]
    # else
    #   @crime_weight = 0.25
    # end

    # if params[:commutescore]
    #   @commutescore_weight = params[:commutescore]
    # else
    #   @commutescore_weight = 0.25
    # end
# # /////////////////////////////////////////////////////////////////////
    # case @crime_rate
    # when "A"
    #   @crimescore = 95
    # when "B"
    #   @crimescore = 85
    # when "C"
    #   @crimescore = 75
    # end

    # @pindex_price = (@price_weight/(@price_range))*(@average_price-@min_price)
    # @pindex_walkscore = @walkscore * @walkscore_weight / 100
    # @pindex_crimerate = @crimescore * @crime_weight / 100
    # @pindex_commutescore = (@commutescore_weight/(@commute_time_range))*(@actual_commute_time-@min_price)

    # @pindex = @pindex_price + @pindex_walkscore + @pindex_crimerate + @pindex_commutescore
#//////////////////////////////////////////////////////////////////////////////

    render 'searches/index', layout: 'layouts/application'
  end

  def index

  end

  private

  def search_params
    params.require(:search).permit(:search_price, :search_city, :search_bedroom, :search_period, :input_address, :input_mode, :input_commute_time)
  end

end


# var latitude = results[0].geometry.location.lat();
# var longitude = results[0].geometry.location.lng();


