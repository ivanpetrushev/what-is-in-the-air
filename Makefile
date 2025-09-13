up:
	docker compose up --build
clear:
	docker compose down -v
prisma-db-push:
	docker compose exec backend npx prisma db push
backend-shell:
	docker compose exec -it backend /bin/sh