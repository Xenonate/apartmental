class ChartsController < ActionController::Base

  def index
    if request.xhr?
      @search=Search.find(params[:search_id])
      @search_result = SearchResult.where(search_id: @search.id, address_id: params[:address_id])
      respond_to do |format|
        format.html #new.html.erb
        format.json { render json: @search_result}
      end
    end
  end

end
