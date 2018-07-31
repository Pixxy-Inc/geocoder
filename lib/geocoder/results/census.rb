require 'geocoder/results/base'

module Geocoder::Result
  class Census < Base

    def coordinates
      coordinates = attributes['coordinates']
      [coordinates['y'].to_f, coordinates['x'].to_f] 
    end

    def latitude
      coordinates[0]
    end

    def longitude
      coordinates[1]
    end

    def address
      attributes['matchedAddress']
    end

    def street
      attributes['streetName']
    end

    def city
      attributes['city']
    end

    def state
      attributes['state']
    end

    alias_method :state_code, :state

    def postal_code
      attributes['zip']
    end

    private

    def attributes
      @data['addressMatches'][0] || {}
    end
    
  end
end