build :
	mkdir -p /home/achakour/data/wordpress
	mkdir -p /home/achakour/data/mariadb
	docker compose -f ./srcs/docker-compose.yml up -d --build 

up :
	docker compose -f ./srcs/docker-compose.yml up -d

fclean:
	docker stop $$(docker ps -qa) 2>/dev/null || true
	docker rm $$(docker ps -qa) 2>/dev/null || true
	docker rmi -f $$(docker images -qa) 2>/dev/null || true
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	docker network rm $$(docker network ls -q) 2>/dev/null || true