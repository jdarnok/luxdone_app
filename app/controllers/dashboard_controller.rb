class DashboardController < ApplicationController
  before_action :set_client, only: [:twitter_search, :show_country_tweets]

  def index
  end

  def twitter_search
    begin
      search = params[:search][:hash].gsub('#', '')
      search = search.prepend("#")
      countries = Country.get_eu_countries
      @tweets_array = Country.search_tweets_in_countries(countries, @client, search)
      @tweets_array
    rescue NoMethodError
      render json: {error: 'Set search param'}, status: 422
    end
  end

  def show_country_tweets
    if params[:search].nil? || params[:country].nil?
      render json: {error: 'Set search param'}, status: 422
    else
      search = params[:search].prepend("#")
      country = Country.find_by(name: params[:country])
      @tweets = @client.search("place:#{country.twitter_id} #{search}").to_a.collect { |tweet| [tweet.user.name, tweet.text] }
    end
  end

  private

  def set_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
    @client
  end

end
