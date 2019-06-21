# KillrVideo Docker Common Configurations

This repo provides a composable set of Docker Compose scripts for running KillrVideo in various configurations

## Basic Docker-Compose Setup

You need to have Docker and docker-compose installed in order to launch the application. Experience with Docker is 
recommended but not required.

Here's how to run the default configuration, which uses the Java backend

```
git clone https://github.com/KillrVideo/killrvideo-docker-common.git 
cd killrvideo-docker-common
docker-compose up -d
```
It'll take some time to pull the images and launch the application. After that, these web interfaces should be available:

* http://localhost:3000 - KillrVideo Web Interface
* http://localhost:9091 - DataStax Studio 

If you use Docker on mac/windows, docker-machine or similar setup, you may need to replace 'localhost' with the IP 
address of your docker machine.

## Customizing the Setup

It is frequently useful for development and deployment purposes to make changes to this common configuration. This repo
also provides a set of override Docker Compose files that operate according to the behaviors described at:
https://docs.docker.com/compose/extends/.

The basic way to use this configuration is to do the following:

```
docker-compose up -d -f docker-compose.yaml <override files> 
```

Alternatively, you can define a `.env` file that lists the `yaml` files you wish to use, along with any environment 
variables needed. For example, the following `.env` would override the Java backend with the Python backend:

```
COMPOSE_PROJECT_NAME=killrvideo
COMPOSE_FILE=./docker-compose.yaml:./docker-compose-backend-python.yaml
```

The override files override various aspects of the default configuration, for example, specifying different images, or
different values for environment variables, and so on. These can be used in various combinations

Quick descriptions of the override files:

* `docker-compose-backend-external.yaml` - adding this file disables the backend services in the compose so you can
run the implementation of your choice locally in your IDE.
* `docker-compose-backend-nodejs.yaml` - adding this file overrides the backend services to the Node.js implementation
* `docker-compose-backend-python.yaml` - adding this file overrides the backend services to the Python implementation
* `docker-compose-dse-external.yaml` - adding this file disables the DSE image in the compose (regardless of any 
additional `docker-compose-dse-*.yaml` files that may have been specified). If using this make sure to define the 
`KILLRVIDEO_EXTERNAL_IP` environment variable
* `docker-compose-dse-metrics.yaml` - adding this file enables metrics collection on DSE and runs Prometheus (port X) 
and Grafana (port X)
* `docker-compose-dse-secure.yaml` - adding this file swaps in DSE configuration files to enable authentication. If using 
this make sure to define the `KILLRVIDEO_DSE_USERNAME` and `KILLRVIDEO_DSE_PASSWORD` environment variables.
* `docker-compose-dse-volumes.yaml` - adding this causes DSE to store its data files in the directory dse-data so that
you may keep the data even when recreating the container
* `docker-compose-ops-center.yaml` - adding this runs an instance of OpsCenter

