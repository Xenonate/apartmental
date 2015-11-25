class MapboxController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def playground
    if request.xhr?
      @search = Search.find(params["search_id"])
      search_results = SearchResult.where(search_id: @search.id)
      addresses = []
      search_results.each do |result|
        addresses << Address.find(result.address_id)
      end
      @long_lat_link = []
      addresses.each do |address|
        @long_lat_link << [[address.long.to_f, address.lat.to_f], address.listing_url]
      end

      respond_to do |format|
        # format.html #new.html.erb
        format.json { render json: @long_lat_link}
      end
    end
  end


end
