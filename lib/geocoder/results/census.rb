require 'geocoder/results/base'

module Geocoder::Result
  class Census < Base

    # {
    #     "result": {
    #       "input": {
    #         "address": {
    #           "address": "4650 N Alafaya Trail, Orlando, FL, US"
    #         },
    #         "benchmark": {
    #           "id": "4",
    #           "isDefault": false,
    #           "benchmarkName": "Public_AR_Current",
    #           "benchmarkDescription": "Public Address Ranges - Current Benchmark"
    #         }
    #       },
    #       "addressMatches": [
    #         {
    #           "addressComponents": {
    #             "state": "FL",
    #             "zip": "32826",
    #             "city": "ORLANDO",
    #             "suffixType": "TRL",
    #             "suffixDirection": "",
    #             "suffixQualifier": "",
    #             "fromAddress": "4698",
    #             "toAddress": "4600",
    #             "preQualifier": "",
    #             "preDirection": "",
    #             "preType": "",
    #             "streetName": "ALAFAYA"
    #           },
    #           "matchedAddress": "4650 ALAFAYA TRL, ORLANDO, FL, 32826",
    #           "coordinates": {
    #             "x": -81.20768,
    #             "y": 28.608665
    #           },
    #           "tigerLine": {
    #             "side": "R",
    #             "tigerLineId": "637844240"
    #           }
    #         }
    #       ]
    #     }
    #   }

    def coordinates
      Rails.logger.info "coordinates ========================"
      coordinates = attributes['coordinates']
      [coordinates['y'].to_f, coordinates['x'].to_f] 
    end

    def latitude
      Rails.logger.info "lat ========================"
      coordinates[0]
    end

    def longitude
      Rails.logger.info "lon ========================"
      coordinates[1]
    end

    def address
      Rails.logger.info "address ========================"
      attributes['matchedAddress']
    end

    def street
      Rails.logger.info "street ========================"
      attributes['streetName']
    end

    def city
      Rails.logger.info "city ========================"
      attributes['city']
    end

    def state
      Rails.logger.info "state ========================"
      attributes['state']
    end

    alias_method :state_code, :state

    def postal_code
      Rails.logger.info "postal_code ========================"
      attributes['zip']
    end

    private

    def attributes
      @data[1]['addressMatches'][0]
    end
    
  end
end