require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    require 'open-uri'
    
    api4 = "https://api.darksky.net/forecast/3fead6d1fd0b0d74265dc83b9ad7d609/"
    api5 = @lat
    api6 = @lng
    
    url2 = api4 + api5 + "," + api6
    
    raw_data2 = open(url2).read
    parsed_results = JSON.parse(raw_data2)
    
    @current_temperature = "Replace this string with your answer."

    @current_summary = parsed_results["minutely"]["summary"]

    @summary_of_next_sixty_minutes = "Replace this string with your answer."

    @summary_of_next_several_hours = "Replace this string with your answer."

    @summary_of_next_several_days = "Replace this string with your answer."

    render("forecast/coords_to_weather.html.erb")
  end
end
