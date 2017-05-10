Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :yelp, ENV['YELPCLIENT_ID'], ENV['YELPSECRET']
  provider :osm, ENV['OSMCLIENT_ID'], ENV['OSMSECRET']
end