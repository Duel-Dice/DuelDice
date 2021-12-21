# Vars =========================

PROJECT	=	dueldice
IMAGES	=	petercha2000/dueldice:backend

# Rules =========================

all		: build push clean

server	: dist clean

build	:
	sudo docker-compose build

push	:
	sudo docker-compose push

clean	:
	@sudo docker rmi $(shell (sudo docker images --filter "dangling=true" -q --no-trunc)) 2>/dev/null | cat

fclean	: clean
	sudo docker-compose -p $(PROJECT) down
	sudo docker-compose -p $(PROJECT) rm
	sudo docker rmi $(IMAGES)

dist	:
	sudo docker-compose pull
	sudo docker-compose -p $(PROJECT) up -d 

re		: fclean all

.PHONY: all build push fclean re dist
