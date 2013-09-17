class Tweet < ActiveRecord::Base
  self.table_name = 'Tweet'
  

  acts_as_gmappable
      def gmaps4rails_address
        self.latitude
        self.longitude
      end
      def gmaps4rails_infowindow
         "<h4>#{self.id_user}</h4>" << "<h4>#{self.text}</h4>"
      end
 

end
