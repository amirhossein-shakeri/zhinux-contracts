PROTO_DIR := .
GEN_DIR := gen/go

PROTO_FILES := $(shell find $(PROTO_DIR) -name "*.proto")

.PHONY: generate
generate:
	protoc \
		--go_out=$(GEN_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_out=$(GEN_DIR) \
		--go-grpc_opt=paths=source_relative \
		$(PROTO_FILES)

.PHONY: clean
clean:
	rm -rf $(GEN_DIR)

.PHONY: lint
lint:
	buf lint
