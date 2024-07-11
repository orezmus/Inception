DOCKER_COMPOSE_PATH	= ./srcs/docker-compose.yml
DATA_DIR			= /home/${USER}/data

all: init build up

init:
	mkdir -p $(DATA_DIR) $(DATA_DIR)/wordpress $(DATA_DIR)/mariadb
	sudo chown -R 100 $(DATA_DIR)/mariadb
	sudo chmod -R 770 $(DATA_DIR)/mariadb

up:
	docker-compose -f $(DOCKER_COMPOSE_PATH) up -d --remove-orphans

down:
	docker-compose -f $(DOCKER_COMPOSE_PATH) down

build:
	docker-compose -f $(DOCKER_COMPOSE_PATH) build

restart:
	docker-compose -f $(DOCKER_COMPOSE_PATH) restart

logs:
	docker-compose -f $(DOCKER_COMPOSE_PATH) logs

fclean: down
	docker system prune --all --force --volumes
	sudo rm -rf $(DATA_DIR)

re: fclean all

.PHONY:
.SILENT: