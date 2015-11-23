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
     # call = "mode=#{search_params[:search_mode]}&origin=#{address.lat},#{address.long}&destination=#{coords.lat},#{coords.lng}"
     # url = URI.parse(URI.encode("http://api2.walkscore.com/api/v1/traveltime/json?wsapikey=b72221d8763203418d081f140357696e&#{call}"))
     # json = HTTParty.get(url)
     # response = JSON.parse(json.body)
      p "*" * 50
     # @commute_time = (response["response"]["results"][0]["travel_times"][0]["seconds"])/60 #in mins

      @walkscore = address.walkscore.to_i

      @price_range = (search_params[:search_max_price].to_i-search_params[:search_min_price].to_i)

      #@commute_time_range = (search_params[:search_max_time].to_i-search_params[:search_min_time].to_i)


      # def get_weight(type, param)
      #   if param
      #     type = param
      #   else
      #     type = 0.25
      #   end
      # end

      # get_weight(@price_weight, params[:price_weight])
      # get_weight(@walkscore_weight, search_params[:walkscore_weight])
      # get_weight(@crime_weight, search_params[:crime_weight])
      # get_weight(@commutescore_weight, search_params[:commutescore])


      @total_weight = @price_weight + @commute_weight + @walkscore_weight + @crime_weight

      case @crime_rate
      when "A"
        @crimescore = 95
      when "B"
        @crimescore = 85
      when "C"
        @crimescore = 75
      end

        # p "price weight"
        # p (@price_weight.to_f/@total_weight.to_f)
        # p "total weight"
        # p (@average_price - search_params[:search_min_price].to_i)/(@price_range)
        # p "average price"
        # p @average_price
        # p search_params[:search_min_price].to_i
        # p "price range"
        # p @price_range
        # p "pindex price"
      @price_weight = search_params[:price_weight].to_i
      @commute_weight = search_params[:commute_weight].to_i
      @walkscore_weight = search_params[:walkscore_weight].to_i
      @crime_weight = search_params[:crime_weight].to_i



      p @pindex_price = (@price_weight.to_f/@total_weight.to_f)*(@average_price.to_f-search_params[:search_min_price].to_f)/(@price_range.to_f)
       "*" * 50
      p @pindex_walkscore = @walkscore.to_f * @walkscore_weight.to_f / @total_weight.to_f
       "*" * 50
      p @pindex_crimerate = @crimescore.to_f * @crime_weight.to_f / @total_weight.to_f
       "*" * 50
      p @pindex_commutescore = (@commute_weight.to_f / @total_weight.to_f)*(search_params[:search_min_time].to_f-@commute_time / @commute_time_range.to_f)

      p "pindex"
      p @pindex = @pindex_price + @pindex_walkscore + @pindex_crimerate #+ @pindex_commutescore



      @sorted_results[@pindex] = {
        "address" => address,
        "pindex_price" => @pindex_price,
        "pindex_walkscore" => @pindex_walkscore,
        "pindex_commutescore" => @pindex_walkscore,
        "pindex_crimerate" => @pindex_crimerate,
        "price_weight" => @price_weight,
        "commute_weight" => @commute_weight,
        "walkscore_weight" => @walkscore_weight,
        "crime_weight" => @crime_weight
      }

      # p "@walkscore.to_f"
      # p @walkscore.to_f
      # p "@walkscore_weight.to_f"
      # p @walkscore_weight.to_f
      # p "@total_weight.to_f"
      # p @total_weight.to_f
      # p @pindex_walkscore

      # p "@crimescore.to_f"
      # p @crimescore.to_f
      # p "@crime_weight.to_f"
      # p @crime_weight.to_f
      # p "@total_weight.to_f"
      # p @total_weight.to_f
      # p @pindex_crimerate


    end

    @sorted_results.sort_by{|key, value| key}
    p "*" * 50
    @sorted_results.each_value do |value|
        p value
      end

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


