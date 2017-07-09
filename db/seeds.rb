# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
countries = ISO3166::Country.find_all_countries_by_region('Europe').collect { |c| c.name }
countries_sliced = countries.each_slice(4).to_a
client = Twitter::REST::Client.new do |config|
  config.consumer_key        =  ENV['CONSUMER_KEY']
  config.consumer_secret     =  ENV['CONSUMER_SECRET']
  config.access_token        =  ENV['ACCESS_TOKEN']
  config.access_token_secret =  ENV['ACCESS_TOKEN_SECRET']
end
countries_sliced.each do |sliced_array|
  sliced_array.each do |country|
    puts "adding #{country}\n"
    begin
      Country.create(twitter_id: client.geo_search(query: country).first.id, name: country)
    rescue Twitter::Error::TooManyRequests
      sleep 901
    end
  end
end