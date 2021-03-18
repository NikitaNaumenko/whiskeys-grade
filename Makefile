# =========================================
# Makes it possible to run "make aaa bbb" instead of make aaa ARGS="bbb"
ARGS = $(filter-out $@,$(MAKECMDGOALS))
%:
	@:
# =========================================

setup:
	bin/setup

start-rails:
	rm -rf tmp/pids/server.pid
	bundle exec rails s -p 3000 -b '0.0.0.0'
start-webpacker:
	bin/webpack-dev-server

test:
	bin/rails test -d

compose:
	docker-compose up -d db

db-prepare:
	bin/rails db:drop || true
	bin/rails db:prepare || true
	bin/rails db:fixtures:load || true

db-reset:
	bin/rails db:drop || true
	bin/rails db:create || true
	bin/rails db:migrate || true
	bin/rails db:fixtures:load || true

lint:
	git ls-files -m | xargs ls -1 2>/dev/null | xargs bundle exec rubocop

lint-autofix:
	git ls-files -m | xargs ls -1 2>/dev/null | xargs bundle exec rubocop -a

ci-lint:
	git diff-tree -r --diff-filter=CDMR --name-only head origin/master | xargs bundle exec rubocop --force-exclusion
ci-check: test ci-lint

.PHONY: test
