class MapController < ApplicationController
  def index
    @json = Tweet.all.to_gmaps4rails
    @latitude = Tweet.where("latitude != 0").last.latitude
    @longitude = Tweet.where("longitude != 0").last.longitude
    gon.latitude = @latitude
    gon.longitude = @longitude
    @tweets = Tweet.order('id_tweet DESC').page(params[:page]).per(5)
    # Only load tweets with localization
    @tweets = @tweets.where('latitude!=0 || longitude!=0')
    #Ajax rendering for the Tweets
    respond_to do |format|
      format.html # index.html.erb
      ajax_respond format, :section_id => "page"
    end
  end
  
  def about  
  end
  
  def statistics
  end

end