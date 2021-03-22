[![On Push](https://github.com/NikitaNaumenko/whiskeys-grade/actions/workflows/push.yaml/badge.svg)](https://github.com/NikitaNaumenko/whiskeys-grade/actions/workflows/push.yaml)

# Whisky grades
## Setup
### Required
Bare-metal way
* ruby-3.0.0
* node
* heroku CLI
* make
* docker-compose (for running db inside container)

Docker way
* make
* docker
* docker compose

### Steps

Bare-metal way
```sh
make setup
make compose-services # run postgres
make start # run server (see more Procfile)
#or
make start-rails
# other tab
make start-webpacker

make db-reset # reset db
```

Docker way
```sh
make compose-install
make compose

make compose-db-reset # to reset db
```
