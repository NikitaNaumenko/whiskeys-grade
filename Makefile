# =========================================
# Makes it possible to run "make aaa bbb" instead of make aaa ARGS="bbb"
ARGS = $(filter-out $@,$(MAKECMDGOALS))
%:
	@:
# =========================================

setup:
	bin/setup

start:
	bundle exec heroku local

lsp-configure:
	bundle exec yard gems
	bundle exec solargraph bundle

deploy:
	git push heroku master

heroku-console:
	heroku run rails console

heroku-logs:
	heroku logs --tail

start-webpacker:
	bin/webpack-dev-server

test:
	bundle exec rspec spec

compose:
	docker-compose up -d postgres

db-prepare:
	bin/rails db:drop || true
	bin/rails db:prepare || true

db-reset:
	bin/rails db:drop || true
	bin/rails db:create || true
	bin/rails db:migrate || true
	bin/rails db:seed || true

lint:
	git ls-files -m | xargs ls -1 2>/dev/null | xargs bundle exec rubocop

lint-autofix:
	git ls-files -m | xargs ls -1 2>/dev/null | xargs bundle exec rubocop -a

ci-lint:
	git diff-tree -r --diff-filter=CDMR --name-only head origin/master | xargs bundle exec rubocop --force-exclusion

ci-check: db-prepare test ci-lint

.PHONY: test
