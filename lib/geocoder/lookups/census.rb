require 'geocoder/lookups/base'
require "geocoder/results/census"

module Geocoder::Lookup
  class Census < Base

    # CENSUS_API_DOCS: https://www.census.gov/content/dam/Census/data/developers/api-user-guide/api-guide.pdf
    # GEOCODING_API_DOCS: https://geocoding.geo.census.gov/geocoder/Geocoding_Services_API.pdf

    def name
      "Census"
    end

    def query_url(query)
      if query.reverse_geocode? 
        raise NotImplementedError, "Support for 'reverse_geocode?' is not supported by the Census Geocoding API."
      else
        method = "address"
      end
      host = configuration[:host] || "geocoding.geo.census.gov/geocoder/locations"
      Rails.logger.info "url======================"
      Rails.logger.info "#{protocol}://#{host}/#{method}?" + url_query_string(query)
      puts "#{protocol}://#{host}/#{method}?" + url_query_string(query)
      warn( "#{protocol}://#{host}/#{method}?" + url_query_string(query))
      return "#{protocol}://#{host}/#{method}?" + url_query_string(query)
    end

    private # ---------------------------------------------------------------

    def results(query)
      doc = fetch_data(query)
      if doc['result']['addressMatches'].empty?
        # raise_error(Geocoder::Error, "No matches found for address.")
        warn("No matches found for address.")
        return [{}]
      else 
        return [doc['result']['addressMatches'].first]
      end
    end

    def parse_raw_data(raw_data)
      Rails.logger.info "data======================"
      Rails.logger.info raw_data.inspect
      puts raw_data
      warn(raw_data)
      if raw_data.include?("Bandwidth limit exceeded")
        raise_error(Geocoder::OverQueryLimitError) || Geocoder.log(:warn, "Over API query limit.")
      else
        super(raw_data)
      end
    end

    def query_url_params(query)
      params = {
        :benchmark => "Public_AR_Current",
        :format => "json",
        :key => configuration['api_key']
      }.merge(super)
      if query.reverse_geocode?
        raise NotImplementedError, "Support for 'reverse_geocode?' is not supported by the Census Geocoding API."
        # lat,lon = query.coordinates
        # params[:x] = lat
        # params[:y] = lon
      else
        Rails.logger.info "sanitized_text======================"
        Rails.logger.info query.sanitized_text.inspect
        puts query.sanitized_text
        warn(query.sanitized_text)
        address_params = query.sanitized_text.split(",")
        params[:street] = address_params[0]
        params[:city] = address_params[1]
        params[:state] = address_params[2]
        params[:zip] = address_params[3]
      end
      return params
    end

  end
end