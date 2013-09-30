class MapController < ApplicationController
  def index
    @json = Tweet.all.to_gmaps4rails 
    @tweets = Tweet.order('id_tweet DESC').paginate(page: params[:page] , :per_page => 5)
  end
  
  def about
    
  end
  
  def statistics
  end
end
