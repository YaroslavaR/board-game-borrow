#!/bin/bash
bundle install
bin/rails db:migrate RAILS_ENV=development
rake db:seed
bin/rails server