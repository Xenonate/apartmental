class SearchesController < ActionController::Base

  def create

    ap flash[:notice] = SearchesHelper.validate_form_input(search_params)

    if !flash[:notice].empty?
      redirect_to root_path
    else
      @params_hash = {
        "city" => search_params[:search_city],
        "max_price" => search_params[:search_max_price],
        "min_price" => search_params[:search_min_price],
        "bedrooms" => search_params[:search_bedroom],
        "length_of_stay" => search_params[:search_period],
        "work_address" => search_params[:search_address],
        "mode_of_transport" => search_params[:search_mode],
        "max_commute_time" => search_params[:search_max_time],
        "price_weight" => search_params[:price_weight],
        "commute_weight" => search_params[:commute_weight],
        "crime_weight" => search_params[:crime_weight],
        "walkscore_weight" => search_params[:walkscore_weight]
      }

      @search_max_price = search_params[:search_max_price].include?(".") ? search_params[:search_max_price][0...-3] : search_params[:search_max_price]
      @search_min_price = search_params[:search_min_price].include?(".") ? search_params[:search_min_price][0...-3] : search_params[:search_min_price]

      @addresses = Address.where(city: search_params[:search_city], bedrooms: search_params[:search_bedroom]).where('price > ?', @search_min_price).where('price < ?', @search_max_price)
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
        # if !search_params[:search_address]
        #   p "coordsssssssssss"
        #   ap coords = Geokit::Geocoders::GoogleGeocoder.geocode(search_params[:city])
        #   @call = "mode=#{search_params[:search_mode]}&origin=#{address.lat},#{address.long}&destination=#{coords.lat},#{coords.lng}"
        # else
        #   p "coordsssssssssss"
        #   ap coords = Geokit::Geocoders::GoogleGeocoder.geocode(search_params[:search_address])
        #   @call = "mode=#{search_params[:search_mode]}&origin=#{address.lat},#{address.long}&destination=#{coords.lat},#{coords.lng}"
        # end

        @call = "mode=#{search_params[:search_mode]}&origin=#{address.lat},#{address.long}&destination=37.7706312,-122.4167"

        @commute_time = SearchesHelper.request_travel_time(@call)

        @walkscore = SearchesHelper.get_walkscore(address)

        @price_range = SearchesHelper.get_range(@search_max_price, @search_min_price.to_i)

        @commute_time_range = search_params[:search_max_time]

        @price_weight = search_params[:price_weight].to_f
        @commute_weight = search_params[:commute_weight].to_f
        @walkscore_weight = search_params[:walkscore_weight].to_f
        @crime_weight = search_params[:crime_weight].to_f

        @total_weight = @price_weight + @commute_weight + @walkscore_weight + @crime_weight

        @pindex_price = (@price_weight.to_f/@total_weight.to_f)*(@search_max_price.to_f - @average_price.to_f)/(@price_range.to_f) * 100

        @crimescore = SearchesHelper.get_crime_score(@crime_rate)

        @pindex_walkscore = @walkscore.to_f * @walkscore_weight.to_f / @total_weight.to_f

        @pindex_crimerate = @crimescore.to_f * @crime_weight.to_f / @total_weight.to_f

        if @commute_time != 0
          @pindex_commutescore = (@commute_weight.to_f / @total_weight.to_f)*(search_params[:search_max_time].to_f-@commute_time / @commute_time_range.to_f)
        else
          @pindex_commutescore = 0
        end

        @pindex = @pindex_price + @pindex_walkscore + @pindex_crimerate + @pindex_commutescore

        if @pindex_commutescore == 0
          @pindex = @pindex * 4 / 3
        end

        @price_weight = (search_params[:price_weight].to_f / @total_weight.to_f) * 100
        @commute_weight = (search_params[:commute_weight].to_f / @total_weight.to_f) * 100
        @walkscore_weight = (search_params[:walkscore_weight].to_f / @total_weight.to_f) * 100
        @crime_weight = (search_params[:crime_weight].to_f / @total_weight.to_f) * 100

        SearchResult.create(search_id: @search.id, address_id: address.id, pindex:@pindex, pindex_price: @pindex_price, pindex_walkscore: @pindex_walkscore, pindex_commutescore: @pindex_commutescore, pindex_crimerate: @pindex_crimerate, price_weight: @price_weight, commute_weight: @commute_weight, walkscore_weight: @walkscore_weight, crime_weight:@crime_weight)

        if @sorted_results[@pindex]
          @pindex = @pindex + 0.00001
        end
        @sorted_results[@pindex] = {
          "address" => address,
          "search_id" => @search.id
        }

      end

      @sorted_results = Hash[@sorted_results.sort.reverse]

    if @sorted_results.empty?
      flash[:error] = "We got 0 results based on your preference, try again!"
      redirect_to root_path
    else
      render 'searches/index', layout: 'layouts/application'
    end
  end
end

def index

end

private

def search_params
  params.require(:search).permit(:search_min_price, :search_max_price, :search_city, :search_bedroom, :search_period, :search_mode, :search_address, :search_max_time, :walkscore_weight, :crime_weight, :price_weight, :commute_weight)
end

end


# var latitude = results[0].geometry.location.lat();
# var longitude = results[0].geometry.location.lng();


