class Tweet < ActiveRecord::Base
  self.table_name = 'Tweet'
  geocoded_by :address
  after_validation :geocode
end
