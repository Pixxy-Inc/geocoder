require 'geocoder/results/base'

module Geocoder::Result
  class Census < Base

    def coordinates
      coordinate_data = attributes['coordinates']
      Rails.logger.info "coords ===================================="
      Rails.logger.info coordinate_data.inspect
      [coordinate_data['y'].to_f, coordinate_data['x'].to_f] 
    end

    def latitude
      Rails.logger.info "lat ===================================="
      Rails.logger.info coordinates[0].inspect
      coordinates[0]
    end

    def longitude
      Rails.logger.info "lon ===================================="
      Rails.logger.info coordinates[1].inspect
      coordinates[1]
    end

    def address
      Rails.logger.info "matchedAddress ===================================="
      Rails.logger.info @data['matchedAddress']
      attributes['matchedAddress']
    end

    def street
      Rails.logger.info "street ===================================="
      Rails.logger.info @data['street']
      attributes['streetName']
    end

    def city
      Rails.logger.info "city ===================================="
      Rails.logger.info @data['city']
      attributes['city']
    end

    def state
      Rails.logger.info "state ===================================="
      Rails.logger.info @data['state']
      attributes['state']
    end

    alias_method :state_code, :state

    def postal_code
      Rails.logger.info "zip ===================================="
      Rails.logger.info @data['zip']
      attributes['zip']
    end

    private

    def attributes
      Rails.logger.info "attributes ===================================="
      Rails.logger.info @data['addressMatches'][0]
      @data['addressMatches'][0] || {}
    end
    
  end
end