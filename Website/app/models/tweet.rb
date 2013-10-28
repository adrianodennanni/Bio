class Tweet < ActiveRecord::Base
  self.table_name = 'Tweet'
  
  


  acts_as_gmappable
      def gmaps4rails_address
        self.latitude
        self.longitude
      end
      def gmaps4rails_infowindow
        user = User.find_by_id_user(self.id_user)
        "<div id='image'><a target='_blank' href='https://twitter.com/#{user.username}/status/#{self.id}'><img src='#{user.profile_image}' /></a></div>" << "<div id='name'><h1>#{user.name}</h1><h2>@#{user.username}</h2></div>" << "<br />" << "<div id='text'>#{self.text}</div>" << "<div id='picture'><img src='#{self.img_url}' width='290'></div>" << "<div id='date'><h2>#{self.date_tweet.strftime('%d/%m/%Y - %Hh%M')}</h2></div>" 
      end
end
