restart_api_dev:
	docker stop london-api  
	docker rm london-api  
	docker build -t london-ml-build . 
	docker run -d -p 80:80 --name london-api london-ml-build

start_api_dev:
	docker run -d -p 80:80 --name london-api london-ml-build

stop_api_dev:
	docker stop london-api 

init_api_dev:	
	docker build -t london-ml-build .
	docker run -d -p 80:80 --name london-api london-ml-build

get_model_dev:
	chmod 777 ./deploy.sh
	./deploy.sh