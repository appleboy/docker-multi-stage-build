# docker-multi-stage-build

[Multi-Stage][1] Docker Builds for Creating Tiny Go Images

[1]:https://github.com/moby/moby/pull/32063

## Single-stage build

See the [Dockerfile.alpine](./Dockerfile.alpine)

```dockerfile
FROM golang:alpine
WORKDIR /app
ADD . /app
RUN cd /app && go build -o app
ENTRYPOINT ./app
```

build and run as the following command.

```sh
$ docker build -f Dockerfile.alpine -t appleboy/go-app .
$ docker run --rm appleboy/go-app
```

**258 MB**, just for our single little Go binary. 

## Multi-Stage build

See the [Dockerfile.alpine](./Dockerfile.alpine)

```dockerfile
# build stage
FROM golang:alpine AS build-env
ADD . /src
RUN cd /src && go build -o app

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /src/app /app/
EXPOSE 80
ENTRYPOINT ./app
```

build and run as the following command.

```sh
$ docker build -t appleboy/go-app .
$ docker run --rm appleboy/go-app
```

**6.35 MB**. Much better.
