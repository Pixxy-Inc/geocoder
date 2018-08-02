require 'geocoder/results/base'

module Geocoder::Result
  class Census < Base

    def coordinates
      coordinate_data = attributes['coordinates']
      Rails.logger.info "coords ===================================="
      Rails.logger.info coordinate_data.inspect
      return [coordinate_data['y'].to_f, coordinate_data['x'].to_f] 
    end

    def latitude
      Rails.logger.info "lat ===================================="
      Rails.logger.info coordinates[0].inspect
      return coordinates[0]
    end

    def longitude
      Rails.logger.info "lon ===================================="
      Rails.logger.info coordinates[1].inspect
      return coordinates[1]
    end

    def address
      Rails.logger.info "matchedAddress ===================================="
      Rails.logger.info attributes['matchedAddress']
      return attributes['matchedAddress']
    end

    def street
      Rails.logger.info "street ===================================="
      Rails.logger.info attributes['street']
      return attributes['streetName']
    end

    def city
      Rails.logger.info "city ===================================="
      Rails.logger.info attributes['city']
      return attributes['city']
    end

    def state
      Rails.logger.info "state ===================================="
      Rails.logger.info attributes['state']
      return attributes['state']
    end

    alias_method :state_code, :state

    def postal_code
      Rails.logger.info "zip ===================================="
      Rails.logger.info attributes['zip']
      return attributes['zip']
    end

    private

    def attributes
      Rails.logger.info "attributes ===================================="
      Rails.logger.info data.inspect
      Rails.logger.info @data.inspect
      return data['addressMatches'][0] || {}
    end
    
  end
end