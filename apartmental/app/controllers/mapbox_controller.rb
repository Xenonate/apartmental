class MapboxController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def playground
    addresses = Address.all
    @long_lat_link = []
    addresses.each do |address|
      @long_lat_link << [[address.long.to_f, address.lat.to_f], address.url]
    end
  end


end
