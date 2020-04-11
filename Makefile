up:
	docker-compose up -d app web db

down:
	docker-compose down

# Init application after start docker
app-init:
	docker-compose exec app ash -c ' \
		chmod -R 777 /app/storage && \
		composer install && \
		php artisan storage:link && \
		php artisan key:generate'

# Clear laravel cache and optimize
app-clear:
	docker-compose exec app composer dump-autoload
	docker-compose exec app php artisan optimize:clear

# Refresh database
app-db-fresh:
	docker-compose exec app ash -c ' \
		php artisan migrate:fresh && \
		php artisan migrate:fresh --env=testing'

# Refresh database and seeding except testing database
app-db-fresh-seed:
	docker-compose exec app ash -c ' \
		php artisan migrate:fresh --seed && \
		php artisan migrate:fresh --env=testing'

# Sync vendor directory from docker container to local
app-sync-vendor:
	mkdir -p ./src/vendor
	docker cp `docker-compose ps -q app`:/app/vendor/. ./src/vendor

# IDE helper
app-ide-helper:
	docker-compose exec app ash -c ' \
		php artisan ide-helper:eloquent && \
		php artisan ide-helper:models --nowrite && \
		php artisan ide-helper:generate && \
		php artisan ide-helper:meta'
