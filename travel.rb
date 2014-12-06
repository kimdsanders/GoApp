require 'sinatra'
require 'json'
require 'httparty'
require 'nokogiri'
require 'open-uri'
require 'yelp'

#Yelp API keys
Yelp.client.configure do |config|
	config.consumer_key = "*********************"
	config.consumer_secret = "********************"
	config.token = "************************"
	config.token_secret = "**********************"

#Route to the home page/ print random quote
get '/?' do
	doc = Nokogiri::HTML(open('http://everything-everywhere.com/the-ultimate-list-of-inspirational-travel-quotes/'))
	search = doc.css('ol').css('li').children
	@random_quotes = search.sort_by { rand }
	erb :home
end

#Route to the form page
get '/form/?' do
	erb :form
end

#This takes the user input and runs it through the yelp api
post '/form/?' do
		@trip_destination = params[:userzipcode]
		your_destination = HTTParty.get("http://api.wunderground.com/api/d7d5cfdbac5562c6/geolookup/conditions/q/#{@trip_destination}.json")
		@current_temp = your_destination.parsed_response['current_observation']['temp_f'].to_s
		@current_condition = your_destination.parsed_response['current_observation']['weather'].to_s

		dining_results = Yelp.client.search(@trip_destination, { term: 'restaurants', limit: '3', sort: '2' })
		event_results = Yelp.client.search(@trip_destination, { term: 'mall', limit: '3', sort: '2' })
		@first_name = dining_results.businesses[0].name
		@first_rating = dining_results.businesses[0].rating.to_s
		@second_name = dining_results.businesses[1].name
		@second_rating = dining_results.businesses[1].rating.to_s
		@third_name = dining_results.businesses[2].name
		@third_rating = dining_results.businesses[2].rating.to_s
		@first_shop = event_results.businesses[0].name
		@second_shop = event_results.businesses[1].name
		@third_shop = event_results.businesses[2].name
	erb :form
end

#Route to the About page
get '/about/?' do
	erb :about
end

end




