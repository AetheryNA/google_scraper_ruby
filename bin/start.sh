#!/bin/bash

# Exit on fail
set -e

if [ -f tmp/pids/server.pid ]; then
  rm -f tmp/pids/server.pid
fi

# Precompile assets
bundle exec rake assets:clobber
bundle exec rake assets:precompile

# Run pending migrations (if any) and start rails
bundle exec rails db:migrate
bundle exec rails s -p $PORT -b 0.0.0.0
