# Build the host-info binary with no dependencies
FROM golang:1.9.1-alpine3.6 as hi-build
WORKDIR /go/src/app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo hi.go

# Package the binary in its own isolated container
FROM scratch
COPY --from=hi-build /go/src/app/hi /hi
EXPOSE 9898
ENTRYPOINT [ "/hi" ]
