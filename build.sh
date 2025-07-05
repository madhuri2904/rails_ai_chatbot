#!/bin/bash

<<<<<<< HEAD
# Install dependencies
bundle install --without development test

# Clear bootsnap cache
bin/rails bootsnap:clear

# Precompile assets
bin/rails assets:precompile

# Run DB migrations
bin/rails db:migrate
=======
# Clear bootsnap cache to prevent stale references
ruby bin/rails bootsnap:clear

# Precompile assets
bundle exec rails assets:precompile

# Run database migrations
bundle exec rails db:migrate
>>>>>>> 0a7b83953cf43335b7369a74ad46d372da23eb4f
