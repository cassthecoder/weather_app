class WelcomeController < ApplicationController
  
 
def index
      @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC).sort!

  response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")

  if params[:city] != nil
    params[:city].gsub!(" ", "_")
  end

  if params[:state] != "" && params[:city] != ""
    if params[:state] != nil && params[:city] != nil
      response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")
    end
  else
    response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")
  end


  @location = response['location']['city']
  @temp_f = response['current_observation']['temp_f']
  @temp_c = response['current_observation']['temp_c']
  @weather_icon = response['current_observation']['icon_url']
  @weather_words = response['current_observation']['weather']
  @forecast_link = response['current_observation']['forecast_url']
  @real_feel_f = response['current_observation']['feelslike_f']
  @real_feel_c = response['current_observation']['feelslike_c']

 if @weather_words == "Clear"
 	@url = "https://snapshotsofwanaka.files.wordpress.com/2013/06/20130606-161727.jpg"
    elsif @weather_words == "Overcast"
    	@url = "https://c1.staticflickr.com/1/93/234702431_d15d54e914.jpg"
 	elsif @weather_words.include?("Cloudy")
 		@url = "http://img12.deviantart.net/2be2/i/2015/354/9/0/partly_cloudy_by_ambr0-d9ksjvs.jpg"
 	elsif @weather_words.include?("Rain")
 		@url = "http://photo.jellyfields.com/image/F@1/12105979383/z/rui-palha,it-s-raining-outside,rainydays-ruipalha.jpg"
 	elsif @weather_words.include?("Thunderstorm")
 		@url = "http://wallpapercave.com/wp/PoqwvZ4.jpg"
 	elsif @weather_words.include?("Snow")
        @url = "http://7-themes.com/data_images/collection/2/4437897-snow-wallpapers.jpg"
 	elsif @weather_words.include?("Fog")
 		@url = "https://upload.wikimedia.org/wikipedia/commons/c/ca/Dense_Seattle_Fog.jpg"	
 else @url = "http://www.pixelstalk.net/wp-content/uploads/2016/11/Flat-design-wallpaper-iphone-620x388.jpg"
 	
 end

end
 
  def test
  response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/AZ/Phoenix.json")
  
  @location = response['location']['city']
  @temp_f = response['current_observation']['temp_f']
  @temp_c = response['current_observation']['temp_c']
  @weather_icon = response['current_observation']['icon_url']
  @weather_words = response['current_observation']['weather'] 
  @forecast_link = response['current_observation']['forecast_url']
  @real_feel = response['current_observation']['feelslike_f']
  end

end
