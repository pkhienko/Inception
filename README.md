# Inception

WordPress infrastructure built with Docker from scratch for the 42Bangkok
curriculum.

## Overview

Inception is a small web infrastructure project built with Docker Compose. It
runs WordPress behind an HTTPS NGINX reverse proxy, uses MariaDB as the
database, and stores application data in persistent host volumes.

The project focuses on containerization, Linux service configuration, private
networking, persistent storage, and secret management. Instead of using a
ready-made WordPress stack, each service is built from a custom Debian-based
Docker image.

## Core Concepts

- Custom Docker images for each service.
- Docker Compose orchestration for NGINX, WordPress/PHP-FPM, and MariaDB.
- HTTPS access through NGINX as the only public entry point.
- Private Docker network for container-to-container communication.
- Persistent volumes for WordPress files and database data.
- Runtime configuration separated from source code.

## Tech Stack

| Area | Technology |
| --- | --- |
| Containerization | Docker, Docker Compose |
| Base image | Debian Bookworm |
| Web server | NGINX |
| Application | WordPress, PHP 8.2 FPM |
| Database | MariaDB |
| Security | HTTPS, Docker secrets |
| Automation | Makefile, Bash, WP-CLI |

## Architecture

<p align="center">
  <img src="assets/architecture.png" alt="Inception Docker architecture diagram" width="720">
</p>

Only NGINX exposes a host port (`443`). WordPress/PHP-FPM and MariaDB stay
inside the Docker network and communicate through service names. WordPress
files and MariaDB data are stored outside the containers so the application can
survive rebuilds and container recreation.

## Main Components

- `nginx`: HTTPS reverse proxy with a generated self-signed certificate.
- `wordpress`: PHP-FPM runtime that downloads and installs WordPress with
  WP-CLI.
- `mariadb`: database container that creates the WordPress database, user, and
  privileges on first run.
- `docker-compose.yml`: orchestration for services, networks, volumes, and
  secrets.
- `Makefile`: developer commands for starting, stopping, cleaning, and fully
  rebuilding the stack.

## How to Run

Create `srcs/.env` with the required environment variables, then run:

```sh
make
```

Common commands:

```sh
make up      # build and start containers
make down    # stop containers
make clean   # stop containers and remove Docker volumes
make fclean  # remove containers, volumes, images, cache, and local data
make re      # full rebuild
```

The first run prompts for secret values and stores them in the ignored
`secrets/` directory.

<details>
<summary>Technical Details</summary>

## Service Details

### NGINX

- Listens on port `443`.
- Serves WordPress from `/var/www/html`.
- Generates a self-signed TLS certificate with OpenSSL.
- Forwards PHP requests to the WordPress container on port `9000`.

### WordPress / PHP-FPM

- Downloads WordPress core if it is missing.
- Copies the project `wp-config.php` template.
- Waits until MariaDB is reachable before installation.
- Installs WordPress and creates the admin/user accounts with WP-CLI.
- Runs `php-fpm8.2` in the foreground.

### MariaDB

- Initializes `/var/lib/mysql` on first run.
- Creates the WordPress database and database user.
- Grants the required privileges.
- Stores database files in a persistent host volume.

## Runtime Flow

1. `make up` creates host directories for WordPress and MariaDB data.
2. The init script creates missing secret files.
3. Docker Compose builds the three custom images.
4. MariaDB initializes the database if needed.
5. WordPress waits for MariaDB, downloads core files, and installs the site.
6. NGINX generates a TLS certificate and exposes the site on HTTPS.

</details>

## References

- [Docker Docs](https://docs.docker.com/reference/dockerfile/)
- [Docker Compose Docs](https://docs.docker.com/reference/compose-file/)
- [NGINX Docs](https://nginx.org/en/docs/)
- [WordPress CLI Docs](https://developer.wordpress.org/cli/commands/)
- [MariaDB Docs](https://mariadb.com/docs/server)
