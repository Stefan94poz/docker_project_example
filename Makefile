PHONY :=
.DEFAULT_GOAL := help
SHELL := /bin/bash

OS := $(shell uname -s)

help:
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##Welcome to Mr Prepare Project to get you started type 'make help'

##
##Docker Commands
##

PHONY += up
up:			## Launch project
up:
	$(call colorecho, "\nStarting project on $(OS)")
	@docker-compose up -d

PHONY += down
down: 			## Tear down project
	$(call colorecho, "\nTear down project docker\n\n- Stoping all containers...\n")
	@docker-compose down

PHONY += recreate
recreate: 			## Recreate docker containers
	$(call colorecho, "Recreate docker containers...\n")
	@docker-compose up -d --build --force-recreate   --remove-orphans

PHONY += restart
restart:		## Restart Docker
restart: down up logs

PHONY += ps
ps:			## Docker containers process status
ps:
	$(call colorecho, "\nDocker containers process status $(OS)")
	@docker-compose ps

PHONY += up-production
up-production:			## Launch project for prod
up-production:
	$(call colorecho, "\nStarting project on $(OS)")
	@docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

PHONY += recreate-production
recreate-production: 			## Recreate docker containers for production
	$(call colorecho, "Recreate production docker containers...\n")
	@docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build --force-recreate --remove-orphans

##
##SSH (Docker)
##

PHONY += ssh
ssh-api:		## SSH to API container
ssh-api:
	$(call colorecho, "\nSSH to API container (nest-api docker image):\n")
	@docker exec -it nest-api /bin/sh

##
##Logs
##

PHONY += logs
logs:			## View Logs from Docker
logs:
	@docker-compose logs -f --tail 100


##
##API Database commands
##

PHONY += migration
migration:	## Create Migration files
migration:
	$(call colorecho, "\nCreating Database Migration:\n")
	@docker exec tikeon-php bin/console doctrine:cache:clear-metadata
	@docker exec tikeon-php bin/console doctrine:migrations:diff

PHONY += migrate
migrate:		## Migrate database
migrate:
	$(call colorecho, "\nMigrating Project Database\n")
	@docker exec tikeon-php bin/console doctrine:migrations:migrate --no-interaction

define colorecho
	@tput -T xterm setaf 3
	@shopt -s xpg_echo && echo $1
	@tput -T xterm sgr0
endef
