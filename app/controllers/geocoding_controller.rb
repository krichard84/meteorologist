require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    
    require 'open-uri'
    
    api1 = "https://maps.googleapis.com/maps/api/geocode/json?address="
    api2 = @street_address
    api3 = "&sensor=false"
    
    url = api1 + api2 + api3
    
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    render("geocoding/street_to_coords.html.erb")
  end
end
