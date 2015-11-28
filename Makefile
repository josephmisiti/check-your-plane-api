analysis:
	ipython notebook
	
database:
	createdb plane
	psql plane -f schema.sql
	python seed_database.py
	
seed:
	python seed_database.py
	
clean:
	dropdb plane
	
build:
	go build -o bin/api api.go	
