class MapController < ApplicationController
  def index
    
    @json = Tweet.all.where('latitude!=0 || longitude!=0')
    @hash = Gmaps4rails.build_markers(@json) do |json, marker|
      marker.lat json.latitude
      marker.lng json.longitude
    end
    
    @q = Tweet.order('id_tweet DESC').where('latitude!=0 || longitude!=0').search(params[:q])
    @latitude = Tweet.where("latitude != 0").last.latitude
    @longitude = Tweet.where("longitude != 0").last.longitude
    gon.latitude = @latitude
    gon.longitude = @longitude
    @tweets = @q.result(distinct: true).page(params[:page]).per(5)
  end
  
  def about  
  end
  
  def statistics
  end
  
end