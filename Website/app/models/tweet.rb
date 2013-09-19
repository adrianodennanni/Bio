class Tweet < ActiveRecord::Base
  self.table_name = 'Tweet'
  
  


  acts_as_gmappable
      def gmaps4rails_address
        self.latitude
        self.longitude
      end
      def gmaps4rails_infowindow
        user = User.find_by_id_user(self.id_user)
        "<h1>#{user.name} <br>@#{user.name}</h1>" << "<h2>#{self.text}<br><br><img src=\"#{self.img_url}\" height=\"400\"></h2>"
      end
 

end
