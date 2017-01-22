REPO=malice
NAME=bitdefender
VERSION=$(shell cat VERSION)

build:
	docker build -t $(REPO)/$(NAME):$(VERSION) .

size: build
	sed -i.bu 's/docker image-.*-blue/docker image-$(shell docker images --format "{{.Size}}" $(REPO)/$(NAME):$(VERSION))-blue/' README.md

tags:
	docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" $(REPO)/$(NAME)

.PHONY: build size tags
