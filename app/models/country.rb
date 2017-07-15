class Country < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :twitter_id, presence: true, uniqueness: true

  def self.get_eu_countries
    eu_countries = []
    ISO3166::Country.find_all_countries_by_region('europe').each do |country|
      eu_countries << country.name unless country.nil?
    end
    countries = Country.where(name: eu_countries)
    countries
  end

  def self.search_tweets_in_countries(countries, client, search)
    tweets_array = []
    countries.each do |country|
      tweets = client.search("place:#{country.twitter_id} #{search}").to_a
      tweets_content = tweets.each.collect{|t| [t.user.name, t.text] }
      tweets_array << {country: country.name, tweets_size: tweets.size, tweets: tweets_content }
    end
    tweets_array = tweets_array.collect { |k| [k[:country], k[:tweets_size]] }
    tweets_array
  end
end