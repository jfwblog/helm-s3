PKG := github.com/jfwblog/helm-s3
GO111MODULE := on

.EXPORT_ALL_VARIABLES:

.PHONY: all
all: deps build

.PHONY: deps
deps:
	whoami
	@go mod download
	@go mod vendor
	@go mod tidy

.PHONY: build
build:
	whoami
	@./hack/build.sh $(CURDIR) $(PKG)

.PHONY: build-local
build-local:
	whoami
	HELM_S3_PLUGIN_VERSION=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") $(MAKE) build

.PHONY: install
install:
	whoami
	@./hack/install.sh

.PHONY: test-unit
test-unit:
	whoami
	go test $$(go list ./... | grep -v e2e)

.PHONY: test-e2e
test-e2e:
	whoami
	go test -v ./tests/e2e/...

.PHONY: test-e2e-local
test-e2e-local:
	whoami
	@./hack/test-e2e-local.sh
