require 'instagram'
 
# Instagram Client ID from http://instagram.com/developer
Instagram.configure do |config|
  config.client_id = 'f3067795cb494ed0b91a9d4c31a8b263'
  config.client_secret =  ENV['INSTA_SECRET']||'secret'
end
 
# Latitude, Longitude for location
instadash_location_lat = '38.702424'
instadash_location_long = '-9.178376'
instadash_distance = '500'
 
SCHEDULER.every '20m', :first_in => 0 do |job|
  photos = Instagram.media_search(instadash_location_lat, instadash_location_long, {:distance => instadash_distance})
  if photos
    photos.map! do |photo|
      { photo: "#{photo.images.standard_resolution.url}" }
    end    
  end
  send_event('instadash', photos: photos)
end