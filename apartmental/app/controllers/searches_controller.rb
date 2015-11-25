class SearchesController < ActionController::Base

  def create
    @addresses = Address.where(city: search_params[:search_city], bedrooms: search_params[:search_bedroom]).where('price > ?', search_params[:search_min_price]).where('price < ?', search_params[:search_max_price])

    @search= Search.create

    @long_lat_link = []

    @addresses.each do |address|
      @long_lat_link << [[address.long.to_f, address.lat.to_f], address.listing_url]
    end

    @length_of_stay = search_params[:search_period] != "" ? search_params[:search_period].to_i : 1
# /////////////////////////////////////////////////////////////////////////////
    @sorted_results = {}
    @addresses.each do |address|
      @average_price = address.rental_average(@length_of_stay)
      @crime_rate = address.crime_rate

      #////Commented out Google API calls //////#

      # coords = Geokit::Geocoders::GoogleGeocoder.geocode(search_params[:search_address])
      #call = "mode=#{search_params[:search_mode]}&origin=#{address.lat},#{address.long}&destination=#{coords.lat},#{coords.lng}"
      call = "mode=#{search_params[:search_mode]}&origin=#{address.lat},#{address.long}&destination=37.7706312,-122.4167"
      url = URI.parse(URI.encode("http://api2.walkscore.com/api/v1/traveltime/json?wsapikey=b72221d8763203418d081f140357696e&#{call}"))
      json = HTTParty.get(url)
      response = JSON.parse(json.body)

      if response
        @commute_time = (response["response"]["results"][0]["travel_times"][0]["seconds"])/60 #in mins
      else
        @commute_time = 0
      end

      @walkscore = address.walkscore.to_i

      @price_range = (search_params[:search_max_price].to_i-search_params[:search_min_price].to_i)

      @commute_time_range = (search_params[:search_max_time].to_i- search_params[:search_min_time].to_i)

      @price_weight = search_params[:price_weight].to_f
      @commute_weight = search_params[:commute_weight].to_f
      @walkscore_weight = search_params[:walkscore_weight].to_f
      @crime_weight = search_params[:crime_weight].to_f

      @total_weight = @price_weight + @commute_weight + @walkscore_weight + @crime_weight

      if @commute_time == 0
        @total_weight = @total_weight * 4 / 3
      end





      case @crime_rate
      when "A"
        @crimescore = 95
      when "B"
        @crimescore = 85
      when "C"
        @crimescore = 75
      end

      @pindex_price = (@price_weight.to_f/@total_weight.to_f)*(search_params[:search_max_price].to_f - @average_price.to_f)/(@price_range.to_f) * 100

      @pindex_walkscore = @walkscore.to_f * @walkscore_weight.to_f / @total_weight.to_f

      @pindex_crimerate = @crimescore.to_f * @crime_weight.to_f / @total_weight.to_f


      @pindex_commutescore = (@commute_weight.to_f / @total_weight.to_f)*(search_params[:search_max_time].to_f-@commute_time / @commute_time_range.to_f)

      @pindex = @pindex_price + @pindex_walkscore + @pindex_crimerate + @pindex_commutescore


      @price_weight = (search_params[:price_weight].to_f / @total_weight.to_f) * 100
      @commute_weight = (search_params[:commute_weight].to_f / @total_weight.to_f) * 100
      @walkscore_weight = (search_params[:walkscore_weight].to_f / @total_weight.to_f) * 100
      @crime_weight = (search_params[:crime_weight].to_f / @total_weight.to_f) * 100
      # p @pindex_price
      # p @pindex_walkscore
      # p @pindex_crimerate
      # p @pindex_commutescore

      SearchResult.create(search_id: @search.id, address_id: address.id, pindex:@pindex, pindex_price: @pindex_price, pindex_walkscore: @pindex_walkscore, pindex_commutescore: @pindex_commutescore, pindex_crimerate: @pindex_crimerate, price_weight: @price_weight, commute_weight: @commute_weight, walkscore_weight: @walkscore_weight, crime_weight:@crime_weight)

      @sorted_results[@pindex] = {
        "address" => address,
        "search_id" => @search.id
      }

    end

    @sorted_results = Hash[@sorted_results.sort.reverse]

    p "*" * 50

    render 'searches/index', layout: 'layouts/application'
  end

  def index

  end

  private

  def search_params
    params.require(:search).permit(:search_min_price, :search_max_price, :search_city, :search_bedroom, :search_period, :search_mode, :search_address, :search_min_time, :search_max_time, :walkscore_weight, :crime_weight, :price_weight, :commute_weight)
  end

end


# var latitude = results[0].geometry.location.lat();
# var longitude = results[0].geometry.location.lng();


