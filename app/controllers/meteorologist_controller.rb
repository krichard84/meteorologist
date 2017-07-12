require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
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

    lat1 = parsed_data["results"][0]["geometry"]["location"]["lat"]

    lng1 = parsed_data["results"][0]["geometry"]["location"]["lng"]

    api4 = "https://api.darksky.net/forecast/3fead6d1fd0b0d74265dc83b9ad7d609/"
    api5 = lat1
    api6 = lng1
    
    link = api4.to_s + api5.to_s + "," + api6.to_s
    
    raw_data2 = open(link).read
    parsed_data2 = JSON.parse(raw_data2)

    @current_temperature = parsed_data2.dig("currently", "temperature")

    @current_summary = parsed_data2.dig("currently", "summary")

    @summary_of_next_sixty_minutes = parsed_data2.dig("minutely", "summary")

    @summary_of_next_several_hours = parsed_data2.dig("hourly", "summary")

    @summary_of_next_several_days = parsed_data2.dig("daily", "summary")

    render("meteorologist/street_to_weather.html.erb")
  end
end
