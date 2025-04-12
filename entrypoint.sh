#!/bin/bash
set -e

echo "Waiting for MySQL to be ready..."
until mysqladmin ping -h "$DATABASE_HOST" -u "$DATABASE_USERNAME" -p"$DATABASE_PASSWORD" --silent; do
  sleep 1
done

echo "MySQL is up. Setting up the app..."

# Remove old server PID if exists
rm -f tmp/pids/server.pid

# Setup DB
bundle exec rails db:create db:migrate

# Run the main container command
exec "$@"
