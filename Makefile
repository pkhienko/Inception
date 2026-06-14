LOGIN		= pkhienko
COMPOSE		= docker compose -f srcs/docker-compose.yml

all:		up

init:
			@ mkdir -p /home/$(LOGIN)/data/mariadb
			@ mkdir -p /home/$(LOGIN)/data/wordpress
			@ bash srcs/requirements/tools/init_config.sh

up:			init
			@ $(COMPOSE) up -d --build

down:
			@ $(COMPOSE) down

clean:
			@ $(COMPOSE) down -v

fclean:
			@ $(COMPOSE) down -v --rmi all
			@ sudo rm -rf /home/$(LOGIN)/data
			@ docker builder prune -af

re:			fclean  up

.PHONY: all init up down clean fclean re
