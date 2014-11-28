class HomeController < ApplicationController

  def index
    if account_signed_in?
      redirect_to :controller => "accounting", :action => "index"
    end
  end

end
