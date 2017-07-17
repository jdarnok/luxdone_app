# luxdone_app
https://serene-coast-99996.herokuapp.com/
## Instalation

Add 
`CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN and ACCESS_TOKEN_SECRET` env variables. You can get them from the twitter app settings

After installing dependencies run:
    `bundle exec rake db:seed`

Due to the request limit, seeding can take several hours

## Test

Run `bundle exec rspec` for tests

## About

Application is using Twitter API for fetching tweets containing hashtags or words that are provided by user. Then, using Google Chart, it is presented on the Geographical Chart. Right now, Twitter search is limitet to the EU countries only. Seeds are fetching twitter_ids of the countries from all over the world though. You can read about rate limits here https://dev.twitter.com/rest/public/rate-limits

To interact with chart, click on a country that has tweets - it will show you authors and contents of the tweets.

After several search requests, you must wait 15 minutes to get request limit back. 
For this app, the next step is propably to remove extra request after clicking on the country. Tweets are fetched after first search when they are presented on the map so there is no need to call api again for the tweets of the particular country - the best way to do this is to just pass those tweets as POST data after click. 
If we want to reduce api calls even more, the best way to achieve this is to have Tweets resource. After each requests, tweets will be stored for 24h - when user search the same keyword, he will get results from the DB  



