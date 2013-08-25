#!/usr/bin/env ruby
require "tweetstream"
require "time"

# Escolha qual palavra deseja filtrar
term = 'partiu'

  TweetStream.configure do |config|
    config.consumer_key       = 'SFiHGCeVr6qMGx9pkxvBg'
    config.consumer_secret    = 'bSu6UDz4TARxGHWqsvCmgJP8JnlJT31IKyaFBJNtcFY'
    config.oauth_token        = '88300988-HMfsqoDKvp5LfjSYomtKMqtF0mx70P2Nf5wIjVC6f'
    config.oauth_token_secret = 'qpbUxivfOyAwLBgYGF1p0R6F4K9WFVaPd2mpmscQgU'
    config.auth_method        = :oauth
  end

p "starting TweetStream.."
TweetStream::Client.new.track(term) do |status|
  puts "@#{status.user.screen_name}"
  puts "#{status.user.name}"
  puts "#{status.text}\n \n"
end
