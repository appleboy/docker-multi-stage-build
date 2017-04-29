
build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

scratch: build
	docker build -f Dockerfile.scratch -t appleboy/go-app .
