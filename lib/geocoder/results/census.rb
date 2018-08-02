require 'geocoder/results/base'

module Geocoder::Result
  class Census < Base

    def longitude
      if @data['coordinates'].empty? 
        return null 
      else
        return @data['coordinates']['x']
      end    
    end
    
    def latitude
      if @data['coordinates'].empty? 
        return null 
      else
        return @data['coordinates']['y']
      end
    end
    
  end
end