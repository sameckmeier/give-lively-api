# give-lively-api

## Dependencies
* ruby 2.7.0
* rails 6.0.3.2
* postgres ~> 12.0 (https://wiki.postgresql.org/wiki/Homebrew for homebrew users)
* bundler ~> 2.1

## Run Instructions
* start postgres (will be different based on how you installed postgres)
* create .env file in root of project dir and add DEVELOPMENT_DB_NAME, TEST_DB_NAME, DB_USERNAME, and DB_PASSWORD with your own values
* bundle install
* rake db:migrate
* rails s

## Run specs
* rspec spec

Enjoy! 🏄‍♂️🏄‍♀️
