populate-env:
	cp .env.example .env || true

lsp-configure:
	bundle exec yard gems
	bundle exec solargraph bundle

start-webpacker:
	bin/webpack-dev-server

test:
	bundle exec rspec spec

db-prepare:
	bin/rails db:drop || true
	bin/rails db:prepare || true

db-reset:
	bin/rails db:drop || true
	bin/rails db:create || true
	bin/rails db:migrate || true
	bin/rails db:seed || true

start-rails:
	rm -rf tmp/pids/server.pid
	bundle exec rails s -p 3000 -b '0.0.0.0'

setup: populate-env
	bin/setup
	bin/rails db:seed || true

start:
	bundle exec heroku local
