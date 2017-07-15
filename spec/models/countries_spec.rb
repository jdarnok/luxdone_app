describe Country do
  describe 'with valid data' do
    before do
      @country = create(:country, :poland)
    end

    it 'has a valid factory' do
      expect(@country).to be_valid
    end

    it 'fetches #trump tweets from Poland' do
      search = '#trump'
      client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['CONSUMER_KEY']
        config.consumer_secret = ENV['CONSUMER_SECRET']
        config.access_token = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
      end
      VCR.use_cassette 'model/twitter_search' do
       search =  client.search("place:#{@country.twitter_id} #{search}")
        expect(search.class.to_s).to eq('Twitter::SearchResults')
      end
    end

    it 'gives eu countries only' do
      create(:country, :germany)
      create(:country, :japan)
      expect(Country.get_eu_countries.size).to eq(2)
    end

  end

  describe 'with invalid data' do

    it 'does not allow duplicated name' do
      create(:country, :poland)
      country2 = build(:country, :poland)
      country2.save
      expect(country2.errors[:name].length).to eq(1)
    end
    it 'does not allow duplicated twitter_id' do
      create(:country, :poland)
      country2 = build(:country, :poland)
      country2.save
      expect(country2.errors[:twitter_id].length).to eq(1)
    end
  end
end