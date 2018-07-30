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
      coordinates = @data['addressMatches'][0]['coordinates']
      Rails.logger.info "coordinates ========================"
      return [coordinates['y'].to_f, coordinates['x'].to_f] 
    end

    def address
      @data['addressMatches'][0]['matchedAddress']
    end

    def street
      @data['addressMatches'][0]['streetName']
    end

    def city
      @data['addressMatches'][0]['city']
    end

    def state
      @data['addressMatches'][0]['state']
    end

    alias_method :state_code, :state

    def postal_code
      @data['addressMatches'][0]['zip']
    end
    
  end
end