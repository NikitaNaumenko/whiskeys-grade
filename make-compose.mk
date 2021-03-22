compose:
	docker-compose up

compose-services:
	docker-compose up -d postgres

compose-install:
	docker-compose run web make setup

compose-db-prepare:
	docker-compose run web make db-prepare

compose-db-reset:
	docker-compose run web make db-reset
