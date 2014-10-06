class MapController < ApplicationController

  def index

    @q = Tweet.order('id DESC').where('latitude!=0 || longitude!=0').search(params[:q])
    if params[:limit]
      @tweets = @q.result(distinct: true).page(params[:page]).per(params[:limit])
    else
      @tweets = @q.result(distinct: true).page(params[:page])
    end



    
    @json = @tweets
            
    @hash = Gmaps4rails.build_markers(@json) do |json, marker|
      # marker recebe alguns parametros para cada marcador
      user=User.find(json.user_id)
      infowindow_content="<div id='image'><a target='_blank' href='https://twitter.com/#{user.username}'><img src='#{user.profile_image}' /></a></div>" << "<div id='name'><h1>#{user.name}</h1><h2>@#{user.username}</h2></div>" << "<br />" << "<div id='text'>#{json.text}</div>" << "<div id='picture'><a target='_blank' href='https://twitter.com/#{user.username}/status/#{json.id}'><img src='#{json.img_url}' width='290'></a></div>" << "<div id='date'><h2>#{json.date_tweet.strftime('%I:%M %p - %d %b %y')}</h2></div>" 
      marker.lat json.latitude
      marker.lng json.longitude
      marker.infowindow infowindow_content
      
      if (json.text.downcase =~ /#florausp(.*)/)
        marker.picture ({
          url: "flowers_cyan.png",
          width:  32,
          height: 37
        })
      elsif (json.text.downcase =~ /#faunausp(.*)/)
        marker.picture ({
          url: "frog-2_cyan.png",
          width:  32,
          height: 37
        })
      elsif (json.text.downcase =~ /#biousp(.*)/)
        marker.picture ({
          url: "arbol_cyan.png",
          width:  32,
          height: 37
        })        
      elsif (json.text.downcase =~ /#florabr(.*)/)
        marker.picture ({
          url: "flowers_green.png",
          width:  32,
          height: 37
        })
      elsif (json.text.downcase =~ /#faunabr(.*)/)
        marker.picture ({
          url: "frog-2_green.png",
          width:  32,
          height: 37
        })
      elsif (json.text.downcase =~ /#biobr(.*)/)
        marker.picture ({
          url: "arbol_green.png",
          width:  32,
          height: 37
        })        
      elsif (json.text.downcase =~ /#worldbio(.*)/)
        marker.picture ({
          url: "arbol_blue.png",
          width:  32,
          height: 37
        })
      end      
    end
    
    if(@json.where("latitude != 0").first != nil)   
      @latitude = @json.where("latitude != 0").first.latitude
      @longitude = @json.where("longitude != 0").first.longitude
     else
       @latitude = 0
       @longitude = 0
     end
    
  end
end
