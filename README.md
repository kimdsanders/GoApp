GoApp
=====

Ruby web application that gets weather, dining and shopping info by zipcode.

It stemmed from this: 

require 'yelp'

Yelp.client.configure do |config|
	config.consumer_key = "**********************"
	config.consumer_secret = "**********************"
	config.token = "**********************"
	config.token_secret = "**********************"
end

def your_destination
	puts "Where are you going?"
	@trip_destination = gets.chomp
end


def top_dining_spots(your_destination)
	dining_results = Yelp.client.search(@trip_destination, { term: 'restaurants', limit: '3', sort: '2' })
	puts "Top Restaurants:"
	puts (dining_results.businesses[0].name) + " is rated " + (dining_results.businesses[0].rating).to_s
	puts (dining_results.businesses[1].name) + " is rated " + (dining_results.businesses[1].rating).to_s
	puts (dining_results.businesses[2].name) + " is rated " + (dining_results.businesses[2].rating).to_s
end

top_dining_spots(your_destination)
