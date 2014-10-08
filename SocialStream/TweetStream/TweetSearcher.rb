#!/usr/bin/env ruby
# encoding: utf-8
# This application filter tweets with specific terms determined below

#Gems required
require 'tweetstream'
require 'twitter'
require 'time'
require 'yaml'
require 'mysql2'
require 'rubygems'
require 'geokit'
require '../../Website/config/environment'

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
  config.oauth_token_secret = APP_CONFIG['OAUTH_TOKEN_SECRET_TWITTER']
  config.auth_method        = :oauth
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = APP_CONFIG['CONSUMER_KEY_TWITTER']
  config.consumer_secret     = APP_CONFIG['CONSUMER_SECRET_TWITTER']
  config.access_token        = APP_CONFIG['OAUTH_TOKEN_TWITTER']
  config.access_token_secret = APP_CONFIG['OAUTH_TOKEN_SECRET_TWITTER']
end


TweetStream::Daemon.new.track(term1,term2,term3,term4,term5,term6, term7) do |status|


  if User.exists?(:id => status.user.id)
    user_query = User.find(status.user.id)
      user_query.name = status.user.name
      user_query.profile_image = status.user.profile_image_url.to_s
      user_query.profile_bio = status.user.description
      user_query.num_followers = status.user.followers_count
      user_query.num_following = status.user.friends_count
      user_query.num_tweets = status.user.statuses_count
      user_query.location = status.user.location
      user_query.website = status.user.url.to_s
    user_query.save
  else
    user_query = User.new
      user_query.id = status.user.id
      user_query.username = status.user.screen_name
      user_query.name = status.user.name
      user_query.profile_image = status.user.profile_image_url.to_s
      user_query.profile_bio = status.user.description
      user_query.num_followers = status.user.followers_count
      user_query.num_following = status.user.friends_count
      user_query.num_tweets = status.user.statuses_count
      user_query.profile_created_at = status.user.created_at
      user_query.location = status.user.location
      user_query.website = status.user.url.to_s
      user_query.up_votes=0
      user_query.down_votes=0
      user_query.reports=0
    user_query.save
  end


  ######## TWEET ########


  # Direct variables
  id_tweet = status.id
  text = status.text

  # Variables that need to be initialized and can't be null
  img_url = ""
  urls = ""
  hashtag = "#"+status.hashtags[0].text

  if (status.media[0]!=nil)
    img_url = status.media[0].media_url.to_s
    #Removing the url from text
    text = text.gsub(img_url, '')
  end

  latitude = status.geo.coordinates[0]
  longitude = status.geo.coordinates[1]

  if latitude.nil?
    latitude=0
    longitude=0
    date_now = Time.now.strftime('%I:%M:%S de %d/%m/%y')
    msg = "@#{status.user.screen_name} Seu Tweet enviado às #{date_now} não foi geolocalizado. Reposte o tweet com a opção 'localização' ativada"
    client.update(msg, :in_reply_to_status_id => id_tweet)
  else

    latlng= Geokit::LatLng.new(latitude,longitude)
    address=Geokit::Geocoders::GoogleGeocoder.reverse_geocode latlng

    if address.full_address!=nil
      full_address=address.full_address
    else
      full_address=""
    end

    if address.city!=nil
      city=address.city
    else
      city=""
    end

    if address.country!=nil
      country=address.country
    else
      country=""
    end

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

  tweet_time = Time.now.to_formatted_s(:db)

  # Saving tweet

  tweet_query = Tweet.new
    tweet_query.id = id_tweet
    tweet_query.text = text
    tweet_query.img_url = img_url
    tweet_query.date_tweet = tweet_time
    tweet_query.latitude = latitude
    tweet_query.longitude = longitude
    tweet_query.full_address = full_address
    tweet_query.city = city
    tweet_query.country = country
    tweet_query.hashtag = hashtag
    tweet_query.urls = urls.to_s
    tweet_query.user_id = status.user.id
    tweet_query.up_votes=0
    tweet_query.down_votes=0
    tweet_query.reports=0
  tweet_query.save

end