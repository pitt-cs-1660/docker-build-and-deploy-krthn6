# build stage
FROM golang:1.23 AS builder
COPY go.mod .
COPY main.go .
COPY templates ./templates
RUN CGO_ENABLED=0 go build -o app .

# final stage
FROM scratch 
COPY --from=builder /go/app /app
COPY --from=builder /go/templates ./templates
CMD ["/myapp"]

