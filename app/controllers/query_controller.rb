class QueryController < ApplicationController
  include HTTParty
  
  def yelpQuery(lat, lon, size)
    
    self.class.get("https://api.yelp.com/v3/businesses/search",
        headers: {"Authorization" => "Bearer #{ENV['YELPACCESSKEY']}"},
        query: {latitude: lat, longitude: lon, radius: (111000*size).to_i}
    )
  end
  
  def osmQuery(lat, lon, size)
    
    self.class.get("http://api.openstreetmap.org/api/0.6/notes.json", { query: {bbox: "#{lon-size},#{lat-size},#{lon+size},#{lat+size}"},
       headers: {"Authorization" => "Bearer #{ENV['OSMACCESSKEY']}",
                 'Content-Type' => 'application/json'
       }
    })
    
  end
  
  def navisensFusingService
    # byebug
    lat = params['lat'].to_f
    lon = params['lon'].to_f
    size = params['size'].to_f # in degree. In this case I treat long & lat the same. At same value to them.
    if lat==0 && lon==0 && size==0
      render plain: "Lat & Lon & Size must have value" and return
    end

    osmJSON = osmQuery(lat, lon, size)
    yelpJSON = yelpQuery(lat, lon, size)
    # byebug
    result = "\nosm\n\n" + osmJSON.body + "\n\nyelp\n\n" + yelpJSON.body
    
    render json: { osm: JSON.parse(osmJSON.body), yelp: JSON.parse(yelpJSON.body) }
    # render json: result
    
  end
end
