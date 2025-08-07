#!/bin/bash
GITHUB_USERNAME=ruandg
GITHUB_EMAIL=smerson0211@gmail.com

SERVICE_NAME=order
RELEASE_VERSION=v1.2.3

go install google.golang.org/protobuf/cmd/protoc-gen-go@latest 
export PATH="$PATH:$(go env GOPATH)/bin"
source ~/.zshrc

echo "Generating Go source code"
mkdir -p golang
protoc --go_out=./golang \
  --go_opt=paths=source_relative \
  --go-grpc_out=./golang \
  --go-grpc_opt=paths=source_relative \
 ./${SERVICE_NAME}/*.proto

echo "Generated Go source code files"
ls -al ./golang/${SERVICE_NAME}

cd golang/${SERVICE_NAME}
go mod init \
  github.com/${GITHUB_USERNAME}/microservices-proto/golang/${SERVICE_NAME} || true
go mod tidy || true
#cd ../../
#git config --global user.email ${GITHUB_EMAIL}
#git config --global user.name ${GITHUB_USERNAME}
#git add . && git commit -am "proto update" || true
#git push -u origin HEAD
#git tag -d ch03/listing_3.2/golang/${SERVICE_NAME}/${RELEASE_VERSION}
#git push --delete origin ch03/listing_3.2/golang/${SERVICE_NAME}/${RELEASE_VERSION}
#git tag -fa ch03/listing_3.2/golang/${SERVICE_NAME}/${RELEASE_VERSION} \
#  -m "ch03/listing_3.2/golang/${SERVICE_NAME}/${RELEASE_VERSION}"
#git push origin refs/tags/ch03/listing_3.2/golang/${SERVICE_NAME}/${RELEASE_VERSION}
