class WelcomeController < ActionController::Base

  def index
    render 'welcome/index', layout: 'layouts/application'
  end

end
