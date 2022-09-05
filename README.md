afterlogic/docker-activeserver
==============================

[Afterlogic ActiveServer](https://afterlogic.com/activeserver) image for Docker using Nginx and PHP-FPM 8.1 on Alpine Linux. Loosely based on [khromov/alpine-nginx-php8 package](https://github.com/khromov/alpine-nginx-php8).

Getting the image
-----------------

* Option 1 - from GitHub - recommended:

```
git clone https://github.com/afterlogic/docker-activeserver .
docker compose up
```

* Option 2 - from DockerHub:
	
```
curl https://raw.githubusercontent.com/afterlogic/docker-activeserver/master/docker-hub-compose.yml --output docker-compose.yml
docker compose up
```

Running Docker image
--------------------

Whether you get the image from DockerHub directly, or build it from GitHub repository, `docker compose up` will run the image, starting Nginx and PHP-FPM. 

In case of GitHub repository, the latest version of ActiveServer is downloaded from the website. DockerHub image is not guaranteed to contain the latest version of the product.

The installation will be available at http://localhost:800/ - if you wish to use another port instead of default 800, adjust `docker-compose.yml` file and edit the following section:

```
    ports:
      - "800:800"
```

Supplying "8080:800" will make sure port 8080 is used, and the installation will be available at http://localhost:8080

Configuring the installation
----------------------------

To configure ActiveServer installation, you'll need to edit `aurora.config.php` file found in root directory of the installation.

Adjusting other configuration files such as `config.php`, `backend/caldav/config.php`, `backend/carddav/config.php`, `backend/imap/config.php` may be needed as well. One of the ways to do that is to copy a configuration file from container to host:

```
docker cp ContainerID:/var/www/html/config.php D:/Temp/config.php
```

where ContainerID is obtained from `docker ps` output, then edit the file locally and copy it back into the container:

```
docker cp D:/Temp/config.php ContainerID:/var/www/html/config.php
```

See [ActiveServer installation instructions](https://afterlogic.com/docs/activeserver/installation) for configuration guidelines.

Licensing Terms & Conditions
----------------------------

Content of this repository is available in terms of The MIT License (see `LICENSE.txt` file)
