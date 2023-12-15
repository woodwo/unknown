
GOBIN		?= $(PWD)/bin
GO			=go

TARGET_DIR	?=$(PWD)/.build
PROTO_DIR	=grpc/proto
PROTO		=$(PROTO_DIR)/unknown.proto
PACKAGE		=github.com/woodwo/unknown

M			=$(shell printf "\033[34;1m>>\033[0m")
# Some tools (like buf or protoc) will search for plugins in PATH, so set
# project local bin to the top priority search path to use versions set in go.mod
export PATH := $(GOBIN):$(PATH)

# protoc compiler should be installed by brew or other package manager
.PHONY: install-tools
install-tools: $(GOBIN) # Install tools needed for development
	$(info $(M) installing tools...)
	@GOBIN=$(GOBIN) $(GO) install -mod=readonly \
	github.com/golang/mock/mockgen \
	google.golang.org/grpc/cmd/protoc-gen-go-grpc \
	google.golang.org/protobuf/cmd/protoc-gen-go

.PHONY: install-lint
install-lint: # Install linter
	$(info $(M) installing linter...)
	@GOBIN=$(GOBIN) $(GO) install -mod=readonly \
	github.com/golangci/golangci-lint/cmd/golangci-lint \

.PHONY: lint
lint: install-lint $(GOBIN) # Run linter
	$(info $(M) running linter...)
	@golangci-lint run

.PHONY: build
build: 
	$(info $(M) building service...)
	@GOOS=$(GOOS) GOARCH=$(GOARCH) $(GO) build -o $(TARGET_DIR)/service ./cmd/*.go

.PHONY: run
run: build 
	$(info $(M) starting service...)
	$(TARGET_DIR)/service

.PHONY: generate
generate:
	$(info $(M) generate service code from proto...)
	@protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative,require_unimplemented_servers=false $(PROTO)

.PHONY: generate-mock
generate-mock: generate
	$(info $(M) generate service code mock...)
	mockgen $(PACKAGE)/$(PROTO_DIR) ComplicatedClient >> $(PROTO_DIR)/mock/mock_unknown.go

# evans go get is [Deprecated], install it by brew ir from GitHub Releases
.PHONY: evans
evans:
	evans $(PROTO) -p 8080

.PHONY: tidy
tidy:
	go mod tidy
%:
	@:
