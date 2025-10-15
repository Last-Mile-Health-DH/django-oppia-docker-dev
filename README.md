# OppiaMobile Docker Development Environment

This repository provides a Docker-based development environment for the OppiaMobile Django server.

## Quick Start

### 1. Clone the Project

```sh
git clone 
cd django-oppia-dev
```

### 3. Rename the example.env file to .env

### 2. Clone the Oppia Server. Eg the Ehiopia IRT application
```sh
cd oppia
```

```sh
git clone https://github.com/OppiaEthiopia/django-oppia.git
# This creates the oppia/django-oppia subdirectory
```

### 3. Prepare Configuration

- Copy the entrypoint script:
  ```sh
  cp appentrypoint.sh django-oppia/appentrypoint.sh
  ```
- Copy your secret settings:
  ```sh
  cp settings_secret.py django-oppia/oppiamobile/settings_secret.py
  ```
  Edit `django-oppia/oppiamobile/settings_secret.py` to match your `.env` file or environment.

### 4. Build and Start the Containers

```sh
docker compose -p oppiaeth up -d --build
```

### 5. Stopping and Cleaning Up

- To stop the containers:
  ```sh
  docker compose -p oppiaeth down
  ```
- To stop and remove volumes:
  ```sh
  docker compose -p oppiaeth down -v
  ```

## Note:-
- The .env does not contain any sensitive information