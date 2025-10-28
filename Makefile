all : up

build : down
	mkdir -p /home/achakour/data/wordpress
	mkdir -p /home/achakour/data/mariadb
	docker compose -f ./srcs/docker-compose.yml up -d --build 

up :
	@docker compose -f ./srcs/docker-compose.yml up -d

down :
	@docker compose -f ./srcs/docker-compose.yml down

stop : 
	@docker compose -f ./srcs/docker-compose.yml stop

start : 
	@docker compose -f ./srcs/docker-compose.yml start

status : 
	@docker ps