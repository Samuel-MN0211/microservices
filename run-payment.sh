#!/bin/bash
GITHUB_USERNAME=ruandg
GITHUB_EMAIL=smerson0211@gmail.com

SERVICE_NAME=payment
RELEASE_VERSION=v1.2.3

go install google.golang.org/protobuf/cmd/protoc-gen-go@latest 
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
export PATH="$PATH:$(go env GOPATH)/bin"

echo "Generating Go source code for ${SERVICE_NAME}"
mkdir -p golang
protoc --go_out=./golang \
  --go_opt=paths=source_relative \
  --go-grpc_out=./golang \
  --go-grpc_opt=paths=source_relative \
 ./${SERVICE_NAME}/*.proto

echo "Generated Go source code files for ${SERVICE_NAME}"
ls -al ./golang/${SERVICE_NAME}

cd golang/${SERVICE_NAME}
go mod init \
  github.com/${GITHUB_USERNAME}/microservices-proto/golang/${SERVICE_NAME} || true
go mod tidy || true

echo "Payment service Go code generation completed!"
