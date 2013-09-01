#!/usr/bin/env ruby
# That's an example how to use TweetStream: https://github.com/tweetstream/tweetstream
# This application filter tweets with specific terms determined below
# Credits to J. H. Kersul

require "tweetstream"
require "time"
require "yaml"
require "mysql"

#Set the location of the config file
APP_CONFIG = YAML.load_file("../config.yml")

# Terms that will be used as parameters to filter tweets
term1 = APP_CONFIG['TERM_1_TWITTER']
term2 = APP_CONFIG['TERM_2_TWITTER']
term3 = APP_CONFIG['TERM_3_TWITTER']
term4 = APP_CONFIG['TERM_4_TWITTER']
term5 = APP_CONFIG['TERM_5_TWITTER']
term6 = APP_CONFIG['TERM_6_TWITTER']
host = APP_CONFIG['HOST_MYSQL']
user = APP_CONFIG['LOGIN_MYSQL']
pass = APP_CONFIG['PASSWORD_MYSQL']
database = APP_CONFIG['DATABASE_MYSQL']

#Database requirements

TweetStream.configure do |config|
  config.consumer_key       = APP_CONFIG['CONSUMER_KEY_TWITTER']
  config.consumer_secret    = APP_CONFIG['CONSUMER_SECRET_TWITTER']
  config.oauth_token        = APP_CONFIG['OAUTH_TOKEN_TWITTER']
  config.oauth_token_secret = APP_CONFIG['OUATH_TOKEN_SECRET_TWITTER']
  config.auth_method        = :oauth
end

connection = Mysql.new host, user, pass, database

puts "Initializing Tweet Searcher"
TweetStream::Client.new.track(term1,term2,term3,term4,term5,term6) do |status|
  puts "@#{status.user.screen_name}"
  puts "#{status.user.name}"
  if status.geo!=nil
    puts "Latitude: #{status.geo.coordinates[0]}"
    puts "Longitude: #{status.geo.coordinates[1]}"
  end
  puts "#{status.text}"
  puts "#{status.user.profile_image_url}"
  puts "Id: #{status.id}\n \n"

  # If the user already exists update the data
  if (connection.query("SELECT id_user FROM User WHERE id_user='#{status.user.id}'").num_rows==0)
    # Saving the user data
    connection.query("INSERT INTO User(id_user, username, name, profile_image) VALUES('#{status.user.id}', \
    '#{status.user.screen_name}', '#{status.user.name}', '#{status.user.profile_image_url}')")
  else
  # Updating the user data
    connection.query("UPDATE `bio`.`User` SET `username`='#{status.user.screen_name}', `name`='#{status.user.name}', \
    `profile_image`='#{status.user.profile_image_url}' WHERE `id_user`='#{status.user.id}'")
  end

  # Saving tweet with geolocalization
  if status.geo!=nil
    connection.query("INSERT INTO Tweet(id_tweet, text, img_url, date_tweet, location_lat, location_long, id_user) VALUES( \
  '#{status.id}', \
  '#{status.text}', \
  '#{status.user.profile_image_url}', \
  NOW(), \
  '#{status.geo.coordinates[0]}', \
  '#{status.geo.coordinates[1]}', \
  '#{status.user.id}')");

  #Saving tweet without geolocalization
  else
    connection.query("INSERT INTO Tweet(id_tweet, text, img_url, date_tweet, location_lat, location_long, id_user) VALUES( \
  '#{status.id}', \
  '#{status.text}', \
  '#{status.user.profile_image_url}', \
  NOW(), \
  NULL, \
  NULL, \
  '#{status.user.id}')");
  end

end

