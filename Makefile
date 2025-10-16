
all : up

build : down
	mkdir -p /home/barbarosa/data/wordpress
	mkdir -p /home/barbarosa/data/mariadb
	docker compose -f ./srcs/docker-compose.yaml up -d --build 

up :
	@docker-compose -f ./srcs/docker-compose.yml up -d

down :
	@docker-compose -f ./srcs/docker-compose.yml down

stop : 
	@docker-compose -f ./srcs/docker-compose.yml stop

start : 
	@docker-compose -f ./srcs/docker-compose.yml start

status : 
	@docker ps