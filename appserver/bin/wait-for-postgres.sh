#!/bin/bash

echo "Waiting for postgres..."

until PGPASSWORD=$POSTGRES_PASSWORD psql -h $POSTGRES_HOST -U $POSTGRES_USER -c '\q' $POSTGRES_DB; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

# Run command | https://docs.docker.com/compose/startup-order/
>&2 echo "PostgreSQL started - executing command"
exec $@