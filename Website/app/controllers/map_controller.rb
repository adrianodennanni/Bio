class MapController < ApplicationController

  def index
    
    
    @q = Tweet.order('id_tweet DESC').where('latitude!=0 || longitude!=0').search(params[:q])
    @latitude = Tweet.where("latitude != 0").last.latitude
    @longitude = Tweet.where("longitude != 0").last.longitude
    @tweets = @q.result(distinct: true).page(params[:page]).per(5)
    
    @json = @tweets
            
    @hash = Gmaps4rails.build_markers(@json) do |json, marker|
      # marker recebe alguns parametros para cada marcador
      user=User.find(json.id_user)
      infowindow_content="<div id='image'><a target='_blank' href='https://twitter.com/#{user.username}'><img src='#{user.profile_image}' /></a></div>" << "<div id='name'><h1>#{user.name}</h1><h2>@#{user.username}</h2></div>" << "<br />" << "<div id='text'>#{json.text}</div>" << "<div id='picture'><a target='_blank' href='https://twitter.com/#{user.username}/status/#{json.id}'><img src='#{json.img_url}' width='290'></a></div>" << "<div id='date'><h2>#{json.date_tweet.strftime('%I:%M %p - %d %b %y')}</h2></div>" 
      marker.lat json.latitude
      marker.lng json.longitude
      marker.infowindow infowindow_content
      
    end
    
  end
  
end