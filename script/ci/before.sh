#!/bin/bash

# Create a database.yml for the right database
echo "Setting up database.yml for $DB"
cp config/database.yml.example config/database.yml

echo "Install PostGIS"
sudo apt-get install postgresql-9.1-postgis

echo "Setup PostGIS template database"
psql -c "CREATE DATABASE template_postgis;" -U postgres
createlang plpgsql template_postgis -U postgres

psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql -q
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql -q

echo "Setup test database"
psql -c "CREATE DATABASE openblight_test WITH TEMPLATE = template_postgis;" -U postgres

echo "Migrate the test database"
bundle exec rake db:test:prepare

echo "Run Migrations"
bundle exec rake db:migrate


# Set up database
#echo "Creating databases for $DB and loading schema"
#bundle exec rake db:schema:load --trace
