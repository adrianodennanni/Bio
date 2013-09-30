class MapController < ApplicationController
  def index
    @tweets = Tweet.all
    @json = @tweets.to_gmaps4rails 
  end
  
  def about
    
  end
  
  def statistics
  end
end
