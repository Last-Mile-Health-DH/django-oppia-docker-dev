#!/bin/bash

set -e

echo "Starting Django entrypoint script..."

# List directory contents for debugging
# ls -la 


# Wait for MySQL to be available
echo "Waiting for MySQL to be available at $MYSQL_HOST:$MYSQL_PORT..."
while ! nc -z "$MYSQL_HOST" "$MYSQL_PORT"; do
  sleep 1
done
echo "MySQL is up!"

# Run migrations with retry logic
echo "Running migrations..."
RETRIES=10
until python manage.py migrate --noinput; do
  RETRIES=$((RETRIES-1))
  if [ $RETRIES -le 0 ]; then
    echo "Migration failed after several attempts, exiting."
    exit 1
  fi
  echo "Migration failed, retrying in 5 seconds..."
  sleep 5
done

# Run migrations for gamification and load default data
python manage.py loaddata oppia/fixtures/default_badges.json
python manage.py loaddata oppia/fixtures/default_gamification_events.json

python manage.py compilescss

python manage.py collectstatic --noinput

# Create superuser if it doesn't exist
echo "Checking for superuser..."
if [ "$DJANGO_SUPERUSER_USERNAME" ] && [ "$DJANGO_SUPERUSER_EMAIL" ] && [ "$DJANGO_SUPERUSER_PASSWORD" ]; then
  python manage.py shell << END
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='$DJANGO_SUPERUSER_USERNAME').exists():
    User.objects.create_superuser('$DJANGO_SUPERUSER_USERNAME', '$DJANGO_SUPERUSER_EMAIL', '$DJANGO_SUPERUSER_PASSWORD')
END
  echo "Superuser ensured."
else
  echo "Superuser environment variables not set, skipping superuser creation."
fi

echo "Starting Django server..."
exec "$@"