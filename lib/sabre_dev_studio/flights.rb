require 'active_support'
require 'active_support/all'

module SabreDevStudio

  class Flights < SabreDevStudio::Base

    def self.bargain_finder_max(options = {})
      request_body = build_bfm_request(options)
      endpoint = '/v1.9.0/shop/flights?mode=live'
      response = SabreDevStudio::Base.post_request(endpoint, request_body.to_json)
      return response
    end

    def self.instaflights(options={})
      request_params = build_instaflights_request(options).to_query
      response = SabreDevStudio::Base.get("/v1/shop/flights?#{request_params}")
      return response
    end

  private

    def self.build_instaflights_request(opts={})
      options = {
        origin:         "NYC",
        destination:    "LON",
        departuredate:  Date.today + 30,
        returndate:     Date.today + 35,
        limit:          10,
        sortby:         "totalfare",
        order:          "asc"
      }.merge(opts)
    end

    def self.build_bfm_request(opts={})
      options = {
        origin: "NYC",
        destination: "LON",
        departs_at: Date.today + 30,
        returns_at: Date.today + 35,
        itins: 50,
        passenger_type: "ADT",
        passenger_count: 2
      }.merge(opts)

      request = {"OTA_AirLowFareSearchRQ" => {
        "OriginDestinationInformation" => [{
          "DepartureDateTime" => options[:departs_at].strftime("%Y-%m-%dT%H:%M:%S"),
          "DestinationLocation" => { "LocationCode" => options[:origin]},
          "OriginLocation" => {"LocationCode" => options[:destination]},
          "RPH" => "1"
        },{
          "DepartureDateTime" => options[:returns_at].strftime("%Y-%m-%dT%H:%M:%S"),
          "DestinationLocation" => { "LocationCode" => options[:destination]},
          "OriginLocation" => {"LocationCode" => options[:origin]},
          "RPH" => "2"
        }],
        "POS" => {
          "Source" => [{"RequestorID" => { "CompanyName" => { "Code" => "TN" }, "ID" => "1", "Type" => "1" }}]
        },
        "TPA_Extensions" => { "IntelliSellTransaction" => { "RequestType" => { "Name" => "#{options[:itins]}ITINS" }}},
        # "TravelPreferences" => { "TPA_Extensions" => { "NumTrips" => { "Number" => 1 }}},
        "TravelerInfoSummary" => { "AirTravelerAvail" => [
          {"PassengerTypeQuantity" => [{ "Code" => options[:passenger_type], "Quantity" => options[:passenger_count] }]}
        ]}
      }}

      # puts "\n\n#{request}\n\n"
      return request
    end

  end

end