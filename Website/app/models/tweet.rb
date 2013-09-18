class Tweet < ActiveRecord::Base
  self.table_name = 'Tweet'
  


  acts_as_gmappable
      def gmaps4rails_address
        self.latitude
        self.longitude
      end
      def gmaps4rails_infowindow
      "<h1>#{self.text}</h1>" << "<img src=\"#{self.img_url}\" height=\"300\">"


      end
 

end
