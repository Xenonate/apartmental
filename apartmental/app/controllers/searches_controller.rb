class SearchesController < ActionController::Base

  def create
    @addresses = Address.where(city: search_params[:search_city], bedrooms: search_params[:search_bedroom]).where('price < ?', search_params[:search_price])
    render 'search/index'
  end

  def index

  end

  private

  def search_params
    params.require(:search).permit(:search_price, :search_city, :search_bedroom, :search_period)
  end

end


# var latitude = results[0].geometry.location.lat();
# var longitude = results[0].geometry.location.lng();

Address.where(city: "San Francisco", bedrooms: '1').where('price < ?', '2000')
