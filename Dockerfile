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
