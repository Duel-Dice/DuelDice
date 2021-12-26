# Vars =========================

PROJECT	=	dueldice
IMAGES	=	\
			petercha2000/dueldice:backend \
			petercha2000/dueldice:admin \
			petercha2000/dueldice:proxy

# Rules =========================

all		: build

.PHONY:	build
build	: clean
	sudo docker-compose -f docker-compose.prod.yml -p $(PROJECT)-prod build
	sudo docker-compose -f docker-compose.prod.yml -p $(PROJECT)-prod push

.PHONY:	prod
prod	: clean
	sudo docker-compose -f docker-compose.prod.yml -p $(PROJECT)-prod pull
	sudo docker-compose -f docker-compose.prod.yml -p $(PROJECT)-prod up -d 

.PHONY:	db
db		:
	sudo docker-compose -f docker-compose.prod.db.yml -p $(PROJECT)-db up -d

.PHONY:	dev
dev		: clean
	sudo docker-compose -f docker-compose.dev.yml -p $(PROJECT)-dev down
	sudo docker-compose -f docker-compose.dev.yml -p $(PROJECT)-dev rm
	sudo docker-compose -f docker-compose.dev.yml -p $(PROJECT)-dev build
	sudo docker-compose -f docker-compose.dev.yml -p $(PROJECT)-dev up -d

.PHONY:	clean
clean	:
	@sudo docker rmi $(shell (sudo docker images --filter "dangling=true" -q --no-trunc)) 2>/dev/null | cat

.PHONY: fclean
fclean	:
	sudo docker-compose -f docker-compose.dev.yml -p $(PROJECT)-prod down
	sudo docker-compose -f docker-compose.dev.yml -p $(PROJECT)-db down
	sudo docker-compose -f docker-compose.dev.yml -p $(PROJECT)-dev down
	sudo docker rmi $(IMAGES)
