class MapController < ApplicationController
  
  def index
    @json = Tweet.all
    @latitude = Tweet.where("latitude != 0").last.latitude
    @longitude = Tweet.where("longitude != 0").last.longitude
    gon.latitude = @latitude
    gon.longitude = @longitude
    @tweets = Tweet.order('id_tweet DESC').page(params[:page]).per(5)
    # Only load tweets with localization
    @tweets = @tweets.where('latitude!=0 || longitude!=0')  
    @search = Tweet.search(params[:q])
    @tweets = @search.result(:distinct => true).where('latitude!=0 || longitude!=0').order('id_tweet DESC').page(params[:page]).per(5)
  end
  
  def about  
  end
  
  def statistics
  end

end
