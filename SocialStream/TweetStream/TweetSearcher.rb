#!/usr/bin/env ruby
# encoding: utf-8
# That's an example how to use TweetStream: https://github.com/tweetstream/tweetstream
# This application filter tweets with specific terms determined below
# Created by J. H. Kersul (data aquisition) and Adriano Dennanni (auto-reply)

require "tweetstream"
require "time"
require "yaml"
require "mysql2"

require 'rubygems'
require 'chatterbot/dsl'

#Set the location of the config file
APP_CONFIG = YAML.load_file("../config.yml")

# Terms that will be used as parameters to filter tweets
term1 = APP_CONFIG['TERM_1_TWITTER']
term2 = APP_CONFIG['TERM_2_TWITTER']
term3 = APP_CONFIG['TERM_3_TWITTER']
term4 = APP_CONFIG['TERM_4_TWITTER']
term5 = APP_CONFIG['TERM_5_TWITTER']
term6 = APP_CONFIG['TERM_6_TWITTER']
term7 = APP_CONFIG['TERM_7_TWITTER']
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

connection = Mysql2::Client.new(:host => host, :username => user, :password => pass, :database => database)

puts "Initializing Tweet Searcher"
TweetStream::Client.new.track(term1,term2,term3,term4,term5,term6, term7) do |status|
  ######## USER ########

  # Direct variables
  id_user = status.user.id
  username = status.user.screen_name
  name = status.user.name
  profile_image = status.user.profile_image_url
  profile_bio = status.user.description
  num_followers = status.user.followers_count
  num_following = status.user.friends_count
  num_tweets = status.user.statuses_count
  profile_created_at = status.user.created_at
  location = status.user.location
  website = status.user.url
  up_votes=0
  down_votes=0
  reports=0
  
  # Saving User
  # If the user already exists update the data
  if (connection.query("SELECT id_user FROM User WHERE id_user='#{id_user}'").count==0)
    # Saving the user data
    connection.query("INSERT INTO User(id_user, username, name, profile_image, profile_bio, \
    num_followers, num_following, num_tweets, profile_created_at, location, website, up_votes, down_votes) VALUES('#{id_user}', \
    '#{username}', '#{name}', '#{profile_image}', '#{profile_bio}', \
    '#{num_followers}', '#{num_following}', '#{num_tweets}', \
    '#{profile_created_at}', '#{location}', '#{website}', '#{up_votes}', '#{down_votes}')")
  else
  # Updating the user data
    connection.query("UPDATE `bio`.`User` SET `username`='#{username}', `name`='#{name}', \
    `profile_image`='#{profile_image}', `profile_bio`='#{profile_bio}', `num_followers`='#{num_followers}', \
    `num_following`='#{num_following}', `num_tweets`='#{num_tweets}', `profile_created_at`='#{profile_created_at}', \
    `location`='#{location}', `website`='#{website}' WHERE `id_user`='#{id_user}'")
  end

  ######## TWEET ########
  # Direct variables
  id_tweet = status.id
  text = status.text
  
  

  # Variables that need to be initialized and can't be null
  img_url = ""
  latitude = 0
  longitude = 0
  urls = ""

  if (status.media[0]!=nil)
    img_url = status.media[0].media_url
    #Removing the url from text
    text = text.gsub(img_url, '') 
  end

  if status.geo!=nil
  latitude = status.geo.coordinates[0]
  longitude = status.geo.coordinates[1]
  else
  reply %Q|#{tweet_user(status)} Infelizmente seu Tweet não está com a geolocalização. Poste o tweet novamente com a opção "localização" ativada.|, status
  end

  i=0
  while status.urls[i]!=nil
    if (urls == "")
    urls = status.urls[i].expanded_url
    else
      urls = urls + " , " + status.urls[i].expanded_url
    end
    i = i + 1
  end

  # Saving tweet
  connection.query("INSERT INTO Tweet(id_tweet, text, img_url, date_tweet, latitude, longitude, urls, id_user, up_votes, down_votes) VALUES( \
  '#{id_tweet}', \
  '#{text}', \
  '#{img_url}', \
  NOW(), \
  '#{latitude}', \
  '#{longitude}', \
  '#{urls}', \
  '#{id_user}', \
  '#{up_votes}', \
  '#{down_votes}')");
  
  ### Printing Data ###
  puts "### USER ###"
  puts "ID User: #{id_user}"
  puts "Username: #{username}"
  puts "Name: #{name}"
  puts "Profile Image: #{profile_image}"
  puts "Profile Bio: #{profile_bio}"
  puts "Num Followers: #{num_followers}"
  puts "Num Following: #{num_following}"
  puts "Num Tweets: #{num_tweets}"
  puts "Date Profile Created: #{profile_created_at}"
  puts "Location: #{location}"
  puts "Website: #{website}"
  puts "### TWEET ###"
  puts "ID Tweet: #{id_tweet}"
  puts "Text: #{text}"
  puts "Image URL: #{img_url}"
  puts "Latitude: #{latitude}"
  puts "Longitude: #{longitude}"
  puts "Urls: #{urls}"
  puts "\n \n"
  
end