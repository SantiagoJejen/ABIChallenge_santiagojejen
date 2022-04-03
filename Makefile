start_dev:
	docker-compose -f ./development/docker-compose-build.yml up

start_dev_d:
	docker-compose -f ./development/docker-compose-build.yml up -d

stop_dev:
	docker-compose -f ./development/docker-compose-build.yml up

restart_dev:
	docker stop london-api  
	docker rm london-api  
	docker build -t london-ml-build . 
	docker run -d -p 80:80 --name london-api london-ml-build

start_api_dev:
	docker run -d -p 80:80 --name london-api london-ml-build
