require 'twitter'
 
Twitter.configure do |config|
  config.consumer_key = 'YOBhbLmBz7cXPCrFDD9w'
  config.consumer_secret = ENV['TWITTER_SECRET']||'secret'
  config.oauth_token = '18718156-Pq8dXpKtfj8wlAXKaNSZPvEzUh0Npdoa5OIARWIFZ'
  config.oauth_token_secret = ENV['TWITTER_OAUTH']||'secret'
end
 
search_term = URI::encode('coworklisboa')
 
SCHEDULER.every '15m', :first_in => 0 do |job|
  tweets = Twitter.search("#{search_term}").results
  if tweets
    tweets.map! do |tweet|
      { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https, link_url: (tweet.urls.first.url unless tweet.urls.empty?) }
    end
    send_event('twitter_mentions', comments: tweets)
  end
end
