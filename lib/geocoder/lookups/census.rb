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
        method = "onelineaddress"
      end
      host = configuration[:host] || "geocoding.geo.census.gov/geocoder/locations"
      return "#{protocol}://#{host}/#{method}?" + url_query_string(query)
    end

    private # ---------------------------------------------------------------

    def results(query)
      doc = fetch_data(query)
      if doc['result']['addressMatches'].empty?
        # raise_error(Geocoder::Error, "No matches found for address.")
        warn("No matches found for address.")
        return {}
      else 
        Rails.logger.info "===================================="
        Rails.logger.info doc['result'].inspect
        return doc['result']
      end
    end

    def parse_raw_data(raw_data)
      if raw_data.include?("Bandwidth limit exceeded")
        raise_error(Geocoder::OverQueryLimitError) || Geocoder.log(:warn, "Over API query limit.")
      else
        super(raw_data)
      end
    end

    def query_url_params(query)
      params = {
        :benchmark => "Public_AR_Current",
        :format => "json"
      }.merge(super)
      if query.reverse_geocode?
        raise NotImplementedError, "Support for 'reverse_geocode?' is not supported by the Census Geocoding API."
        # lat,lon = query.coordinates
        # params[:x] = lat
        # params[:y] = lon
      else
        params[:address] = query.sanitized_text
      end
      return params
    end

  end
end