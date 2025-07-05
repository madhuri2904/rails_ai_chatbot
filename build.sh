#!/bin/bash

# Install dependencies
bundle install --without development test

# Clear bootsnap cache
bin/rails bootsnap:clear

# Precompile assets
bin/rails assets:precompile

# Run DB migrations
bin/rails db:migrate
