class MapController < ApplicationController
  def index
    @json = Tweet.all.to_gmaps4rails 
  end
  
  def about
    
  end
  
  def statistics
  end
  
  def tweets
    @tweets = Tweet.order('id_tweet DESC').paginate(page: params[:page] , :per_page => 5)
  end
end
