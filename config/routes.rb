Rails.application.routes.draw do
  root controller: 'dashboard', action: 'index'
  get 'dashboard/index'
  post 'dashboard/twitter_search'
  get 'tweets/:country', to: 'dashboard#show_country_tweets'
end
