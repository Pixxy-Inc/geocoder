require 'geocoder/results/base'

module Geocoder::Result
  class Census < Base

    def longitude
      @data.empty? ? nil : @data['coordinates']['x']
    end

    def latitude
      @data.empty? ? nil : @data['coordinates']['y']
    end
    
  end
end