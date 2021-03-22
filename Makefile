include make-compose
include make-app
# =========================================
# Makes it possible to run "make aaa bbb" instead of make aaa ARGS="bbb"
ARGS = $(filter-out $@,$(MAKECMDGOALS))
%:
	@:
# =========================================
deploy:
	git push heroku master

heroku-console:
	heroku run rails console

heroku-logs:
	heroku logs --tail

lint:
	git ls-files -m | xargs ls -1 2>/dev/null | xargs bundle exec rubocop

lint-autofix:
	git ls-files -m | xargs ls -1 2>/dev/null | xargs bundle exec rubocop -a

ci-lint:
	git diff-tree -r --diff-filter=CDMR --name-only head origin/master | xargs bundle exec rubocop --force-exclusion

ci-check: db-prepare test ci-lint

.PHONY: test

