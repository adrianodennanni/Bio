class MapController < ApplicationController
  def index
    @json = Tweet.all.to_gmaps4rails
    @latitude = Tweet.where("latitude != 0").last.latitude
    @longitude = Tweet.where("longitude != 0").last.longitude
    gon.latitude = @latitude
    gon.longitude = @longitude 
  end
  
  def about  
  end
  
  
  def statistics
  end

  def infobox
    gon.username=User.username
    gon.tweetid=Tweet.id_tweet
  end
  
 
  def tweets
    @tweets = Tweet.order('id_tweet DESC').paginate(page: params[:page] , :per_page => 5)
    @tweets = @tweets.where('latitude!=0 && longitude!=0')
  end
end
