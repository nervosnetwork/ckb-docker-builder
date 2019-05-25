TAG := nervos/ckb-docker-builder:$(shell $%git rev-parse --abbrev-ref HEAD)

build:
	docker build -t ${TAG} .

run:
	docker run --rm -it ${TAG}

push:
	docker push ${TAG}

show-tag:
	@echo ${TAG}

.PHONY: build run push show-tag
