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

    # def poi
    #   return @data['address'][place_type] if @data['address'].key?(place_type)
    #   return nil
    # end

    # def house_number
    #   @data['address']['house_number']
    # end

    def address
      @data['addressMatches'][0]['matchedAddress']
    end

    def street
      @data['addressMatches'][0]['streetName']
    end

    def city
      @data['addressMatches'][0]['city']
    end

    # def village
    #   @data['address']['village']
    # end

    # def town
    #   @data['address']['town']
    # end

    def state
      @data['addressMatches'][0]['state']
    end

    alias_method :state_code, :state

    def postal_code
      @data['addressMatches'][0]['zip']
    end

    # def county
    #   @data['addressMatches'][0]['zip']
    # end

    # def country
    #   @data['address']['country']
    # end

    # def country_code
    #   @data['address']['country_code']
    # end

    # def suburb
    #   @data['address']['suburb']
    # end

    # def city_district
    #   @data['address']['city_district']
    # end

    # def state_district
    #   @data['address']['state_district']
    # end

    # def neighbourhood
    #   @data['address']['neighbourhood']
    # end

    def coordinates
      coordinates = @data['addressMatches'][0]['coordinates']
      return [coordinates['y'], coordinates['x']] 
    end

    # def place_class
    #   @data['class']
    # end

    # def place_type
    #   @data['type']
    # end

    # def viewport
    #   south, north, west, east = @data['boundingbox'].map(&:to_f)
    #   [south, west, north, east]
    # end

    # def self.response_attributes
    #   %w[result, addressMatches]
    # end

    # response_attributes.each do |a|
    #   unless method_defined?(a)
    #     define_method a do
    #       @data[a]
    #     end
    #   end
    # end
  end
end