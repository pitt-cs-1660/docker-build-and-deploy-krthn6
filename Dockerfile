# build stage
FROM golang:1.23 AS builder
COPY go.mod .
COPY main.go .
COPY templates ./templates
RUN CGO_ENABLED=0 go build -o myapp .

# final stage
FROM scratch 
COPY --from=builder /go/myapp /myapp
COPY --from=builder /go/templates ./templates
CMD ["/myapp"]

