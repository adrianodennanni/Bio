#!/usr/bin/env ruby
# That's an example how to use TweetStream: https://github.com/tweetstream/tweetstream
# This application filter tweets with specific terms determined below
# Credits to J. H. Kersul and Adriano Dennanni

require "tweetstream"
require "time"

# Terms that will be used as parameters to filter tweets
term1 = '#FaunaUSP'
term2 = '#FloraUSP'

  TweetStream.configure do |config|
    config.consumer_key       = 'SFiHGCeVr6qMGx9pkxvBg'
    config.consumer_secret    = 'bSu6UDz4TARxGHWqsvCmgJP8JnlJT31IKyaFBJNtcFY'
    config.oauth_token        = '88300988-HMfsqoDKvp5LfjSYomtKMqtF0mx70P2Nf5wIjVC6f'
    config.oauth_token_secret = 'qpbUxivfOyAwLBgYGF1p0R6F4K9WFVaPd2mpmscQgU'
    config.auth_method        = :oauth
  end

puts "starting TweetStream.."
TweetStream::Client.new.track(term1,term2) do |status|
  puts "@#{status.user.screen_name}"
  puts "#{status.user.name}"
  puts "#{status.text}\n \n"
end