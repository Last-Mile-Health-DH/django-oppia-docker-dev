
# OppiaMobile Docker Development Environment

This repository provides a Docker-based development environment for the OppiaMobile Django server.

## Quick Start

### 1. Clone This Repository

```sh
git clone https://github.com/Last-Mile-Health-DH/django-oppia-docker-dev.git
cd django-oppia-docker-dev
```

### 2. Set Up Environment Variables

- Copy and rename the example environment file:
  ```sh
  cp example.env .env
  ```
- Edit `.env` as needed (it does not contain sensitive information).

### 3. Clone the Oppia Server

```sh
cd oppia
git clone https://github.com/OppiaEthiopia/django-oppia.git
# This creates the oppia/django-oppia subdirectory
cd ..
```

### 4. Prepare Configuration

- Copy the entrypoint script:
  ```sh
  cp appentrypoint.sh oppia/django-oppia/appentrypoint.sh
  ```
- Copy your secret settings:
  ```sh
  cp settings_secret.py oppia/django-oppia/oppiamobile/settings_secret.py
  ```
- Edit `oppia/django-oppia/oppiamobile/settings_secret.py` to match your `.env` file or environment.

### 5. Build and Start the Containers

```sh
docker compose -p oppiaeth up -d --build
```

### 6. Stopping and Cleaning Up

- To stop the containers:
  ```sh
  docker compose -p oppiaeth down
  ```
- To stop and remove volumes:
  ```sh
  docker compose -p oppiaeth down -v
  ```

---
