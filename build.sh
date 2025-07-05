#!/bin/bash

# Clear bootsnap cache to prevent stale references
ruby bin/rails bootsnap:clear

# Precompile assets
bundle exec rails assets:precompile

# Run database migrations
bundle exec rails db:migrate
