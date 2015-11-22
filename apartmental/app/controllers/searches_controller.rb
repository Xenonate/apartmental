class SearchesController < ActionController::Base

  def create
    # @addresses = Address.where(city: search_params[:search_city])
    @addresses = Address.where(city: search_params[:search_city], bedrooms: search_params[:search_bedroom]).where('price > ?', search_params[:search_min_price]).where('price < ?', search_params[:search_max_price])

    @long_lat_link = []
    @addresses.each do |address|
      @long_lat_link << [[address.long.to_f, address.lat.to_f], address.listing_url]
    end
    @length_of_stay = search_params[:search_period] != "" ? search_params[:search_period].to_i : 1
# /////////////////////////////////////////////////////////////////////////////
    @sorted_results = {}
    @addresses.each do |address|
      # p address
      # p address.id
      # p address.price.to_i
      # p "average_price"
      @average_price = address.rental_average(@length_of_stay)
      @crime_rate = address.crime_rate
      coords = Geokit::Geocoders::GoogleGeocoder.geocode(search_params[:search_address])
      call = "mode=#{search_params[:search_mode]}&origin=#{address.lat},#{address.long}&destination=#{coords.lat},#{coords.lng}"
      url = URI.parse(URI.encode("http://api2.walkscore.com/api/v1/traveltime/json?wsapikey=b72221d8763203418d081f140357696e&#{call}"))
      json = HTTParty.get(url)
      response = JSON.parse(json.body)
      p "*" * 50
      @commute_time = (response["response"]["results"][0]["travel_times"][0]["seconds"])/60 #in mins

      @walkscore = address.walkscore.to_i

      @price_range = (search_params[:search_max_price].to_i-search_params[:search_min_price].to_i)

      @commute_time_range = (search_params[:search_max_time].to_i-search_params[:search_min_time].to_i)

  #     get_weight(@price_weight, params[:price_weight])
  #     get_weight(@walkscore_weight, params[:walkscore_weight])
  #     get_weight(@crime_weight, params[:crime_weight])
  #     get_weight(@commutescore_weight, params[:commutescore])


      if params[:price_weight]
        @price_weight = params[:price_weight]
      else
        @price_weight = 0.25
      end

      if params[:walkscore_weight]
        @walkscore_weight = params[:walkscore_weight]
      else
        @walkscore_weight = 0.25
      end

      if params[:crime_weight]
        @crime_weight = params[:crime_weight]
      else
        @crime_weight = 0.25
      end

      if params[:commutescore]
        @commutescore_weight = params[:commutescore]
      else
        @commutescore_weight = 0.25
      end

      case @crime_rate
      when "A"
        @crimescore = 95
      when "B"
        @crimescore = 85
      when "C"
        @crimescore = 75
      end
      p "*" * 50
      p @pindex_price = (@price_weight/(@price_range))*(@average_price-search_params[:search_min_price].to_i)
      p "*" * 50
      p @pindex_walkscore = @walkscore * @walkscore_weight / 100
      p "*" * 50
      p @pindex_crimerate = @crimescore * @crime_weight / 100
      p "*" * 50
      p @pindex_commutescore = (@commutescore_weight/(@commute_time_range))*(search_params[:search_min_time].to_i-@commute_time)
      p "pindex"
      p @pindex = @pindex_price + @pindex_walkscore + @pindex_crimerate + @pindex_commutescore

      @sorted_results[@pindex] = address

    end

    @sorted_results.sort_by{|key, value| key}

    render 'searches/index', layout: 'layouts/application'
  end

  def index

  end

  private

  def search_params
    params.require(:search).permit(:search_min_price, :search_max_price, :search_city, :search_bedroom, :search_period, :search_mode, :search_address, :search_min_time, :search_max_time)
  end

end


# var latitude = results[0].geometry.location.lat();
# var longitude = results[0].geometry.location.lng();


