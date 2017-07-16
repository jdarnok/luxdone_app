RSpec.describe DashboardController, type: :controller do

  describe 'GET #index' do
    it 'renders index page' do
      get :index
      expect(response).to render_template :index
      # payload = JSON.parse response.body
      # expect(response).to have_http_status(:success)
      # expect(payload['_id']['$oid']).to eq(current_user.id.to_s)
    end
  end

  describe 'POST #twitter_search' do
    before do
      create(:country, :poland)
      create(:country, :germany)
    end
    context 'with params[:search]' do
      it 'populates an array of tweets based on countries from the DB' do
        VCR.use_cassette 'controller/twitter_search' do
          post :twitter_search, params: {search: {hash: '#trump'}}
          expect(assigns(:tweets_array).size).to eq(2)
        end
      end
    end
    context 'without params[:search]' do
      it 'responds with status 422' do
        post :twitter_search
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'POST #show_country_tweets' do
    before do
      create(:country, :poland)
    end
    context 'with params[:country] and params[:search]' do
      it 'populates an array of tweets from the specific country' do
        VCR.use_cassette 'controller/place_search' do
          post :show_country_tweets, params: {country: 'Poland', search: '#trump'}
          expect(assigns(:tweets)).to be_an(Array)
        end
      end
    end
    context 'without params[:search]' do
      it 'responds with status 422' do
          post :show_country_tweets, params: {country: 'Poland'}
          expect(response.status).to eq(422)
      end
    end
  end
end
