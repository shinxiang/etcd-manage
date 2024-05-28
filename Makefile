default:
	@echo 'Usage of make: [ build | linux_build | windows_build | docker_build | docker_run | clean ]'

build: 
	@go build -o ./bin/etcd-manage ./

linux_build: 
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./bin/etcd-manage ./

windows_build: 
	@CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o ./bin/etcd-manage.exe ./

docker_build: linux_build
	docker build -t shinxiang/etcd-manage .

docker_run: docker_build
	docker-compose up --force-recreate

run: build
	@./bin/etcd-manage

install: build
	@mv ./bin/etcd-manage $(GOPATH)/bin/etcd-manage

clean: 
	@rm -f ./bin/etcd-manage*
	@rm -f ./bin/logs/*

.PHONY: default build linux_build windows_build docker_build docker_run clean