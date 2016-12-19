# _Coding Notes_

#### By _Diego Suarez, Joshua Rinard, Kevin Finley, Getro Naissance 12/19/2016_

## Description

Coding notes is a group project to build an app that allows the user to save snippets of code for future reference.

**User Stories**

* As a user, I want to create folders/categories for my code to be saved
* As a user, I want to create snippets within those folders
* As a user, I want to be able to view code with the colors of the code type.
* As a user, I want to be able to search through the site for a specific snippet
* As a user, I want to be able to highlight specific code to view more details

## Setup/Installation Requirements

* Clone this repo: `git clone git@github.com:name/DiegoSPB/coding_notes`
* Change to the repo directory: `cd coding_notes`
* Install gems: `bundle install --path vendor/bundle`
* Install the database: *instruction below*
* Run the app: `ruby app.rb`

## Database Setup Instructions

* install and start postgres
* run: `bundle exec rake db:create`
* run: `bundle exec rake db:migrate`
* run: `bundle exec rake db:test:prepare`

## Technologies Used

_Ruby, Sinatra, SQL, Postgres, JavaScript, MaterializeCSS, jQuery_

### License

*MIT License*

Copyright (c) 2016 **_Diego Suarez, Joshua Rinard, Kevin Finley, Getro Naissance_**
