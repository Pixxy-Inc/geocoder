require 'geocoder/lookups/base'
require "geocoder/results/census"

module Geocoder::Lookup
  class Census < Base

    def name
      "Census"
    end

    def map_link_url(coordinates)
      "http://www.openstreetmap.org/?lat=#{coordinates[0]}&lon=#{coordinates[1]}&zoom=15&layers=M"
    end

    # get lat, lon by address
    # https://geocoding.geo.census.gov/geocoder/locations/address?parameters

    # get address from coordinates
    # https://geocoding.geo.census.gov/geocoder/locations/coordinates?parameters

    def query_url(query)
      method = query.reverse_geocode? ? "coordinates" : "onelineaddress"
      host = configuration[:host] || "geocoding.geo.census.gov/geocoder/locations"
      Rails.logger.info "query_url ==================="
      Rails.logger.info "#{protocol}://#{host}/#{method}?" + url_query_string(query)
      "#{protocol}://#{host}/#{method}?" + url_query_string(query)
    end

    private # ---------------------------------------------------------------

    def results(query)
    #   return [] unless doc = fetch_data(query)
      Rails.logger.info "getting_results ====================="
      doc = fetch_data(query)
      Rails.logger.info doc.inspect
      return doc
    end

    def parse_raw_data(raw_data)
    Rails.logger.info "parse_raw_data ========================"
      if raw_data.include?("Bandwidth limit exceeded")
        raise_error(Geocoder::OverQueryLimitError) || Geocoder.log(:warn, "Over API query limit.")
      else
        super(raw_data)
      end
    end

    def query_url_params(query)
        Rails.logger.info "query_url_params ========================"
      # https://geocoding.geo.census.gov/geocoder/Geocoding_Services_API.pdf
      params = {
        :benchmark => "Public_AR_Current",
        :format => "json"
      }.merge(super)
      if query.reverse_geocode?
        lat,lon = query.coordinates
        params[:x] = lat
        params[:y] = lon
      else
        params[:address] = query.sanitized_text
      end
      params
    end
  end
end
