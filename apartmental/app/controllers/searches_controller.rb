class SearchesController < ActionController::Base

  def create
    @addresses = Address.where(city: search_params[:search_city], bedrooms: search_params[:search_bedroom]).where('price < ?', search_params[:search_price])

    @long_lat_link = []
    @addresses.each do |address|
      @long_lat_link << [[address.long.to_f, address.lat.to_f], address.url]
    end

    @length_of_stay = search_params[:search_period].to_i

    render 'searches/index'
  end

  def index

  end

  private

  def search_params
    params.require(:search).permit(:search_price, :search_city, :search_bedroom, :search_period, :length_of_stay)
  end

end


# var latitude = results[0].geometry.location.lat();
# var longitude = results[0].geometry.location.lng();


