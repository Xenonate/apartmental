class ChartsController < ActionController::Base

  def index
    if request.xhr?
      if params["first_load"]
        @search=Search.find(params[:search_id])
        @search_result = SearchResult.where(search_id: @search.id, address_id: params[:address_id])
        respond_to do |format|
          format.html #new.html.erb
          format.json { render json: @search_result}
        end
      else
        @search=Search.find(params[:search_id])
        @search_result = SearchResult.where(search_id: @search.id, address_id: params[:address_id])
        respond_to do |format|
          # format.html #new.html.erb
          format.json { render json: @search_result}
        end
      end
    end
  end

  def new
    if request.xhr?
      @address=Address.find(params[:address_id])
      @description = Address.get_description(@address.listing_url)
      a = {"description" => @description,}
      respond_to do |format|
        # format.html #new.html.erb
        format.json { render json: a}
      end
    else
      render 'index'
    end
  end

end
