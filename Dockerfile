FROM golang:alpine

ENV KAFKA_CONNECT_EXPORTER_PORT=8080 \
    KAFKA_CONNECT_URI='http://127.0.0.1:8083'


COPY ./src/kafka_connect_exporter.go /kafka_connect_exporter/kafka_connect_exporter.go
COPY ./src/go.mod /kafka_connect_exporter/go.mod
COPY ./src/go.sum /kafka_connect_exporter/go.sum

RUN apk update && \
    apk upgrade && \
    apk add git

CMD ["echo", "Kafka Connect Exporter"]
ENTRYPOINT cd /kafka_connect_exporter && go run kafka_connect_exporter.go -listen-address=:$KAFKA_CONNECT_EXPORTER_PORT -scrape-uri=$KAFKA_CONNECT_URI