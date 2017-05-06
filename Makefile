REPO=malice
NAME=bitdefender
VERSION=$(shell cat VERSION)

all: build size test

build:
	docker build -t $(REPO)/$(NAME):$(VERSION) .

size:
	sed -i.bu 's/docker%20image-.*-blue/docker%20image-$(shell docker images --format "{{.Size}}" $(REPO)/$(NAME):$(VERSION)| cut -d' ' -f1)-blue/' README.md

tags:
	docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" $(REPO)/$(NAME)

test:
	docker run --init --rm $(REPO)/$(NAME):$(VERSION) -V -t EICAR

.PHONY: build size tags test
