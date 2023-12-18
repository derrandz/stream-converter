# Variables
GOMOD_NAME := "github.com/derrandz/stream-converter"

## help: Get more info on make commands.
help: Makefile
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
.PHONY: help

## clean: remove existing build
clean:
	rm -rf ./build/*

## lint-imports: Lint only Go imports.
## flag -set-exit-status doesn't exit with code 1 as it should
## so we use find until it is fixed by goimports-reviser
lint-imports:
	@for file in `find . -type f -name '*.go'`; \
		do \
			goimports-reviser \
				-list-diff \
				-set-exit-status \
				-company-prefixes "github.com/derrandz" \
				-project-name "github.com/derrandz/stream-converter" \
				-output stdout $$file \
			 || exit 1;  \
	done;
.PHONY: lint-imports

## sort-imports: Sort Go imports.
sort-imports:
	@goimports-reviser \
		-company-prefixes "github.com/derrandz" \
		-project-name "github.com/derrandz/stream-converter" \
		-output stdout ./...
.PHONY: sort-imports

## fmt: Formats only *.go
fmt: sort-imports
	@find . -name '*.go' -type f -not -path "*.git*" | xargs gofmt -w -s
	@find . -name '*.go' -type f -not -path "*.git*" | xargs goimports -w -local github.com/derrandz
	@go mod tidy -compat=1.20
	@cfmt -w -m=100 ./...
.PHONY: fmt

## lint: Linting *.go files using golangci-lint. Look for .golangci.yml for the list of linters.
lint: lint-imports
	@echo "--> Running linter"
	@golangci-lint run --config ./.golangci.yml
	@cfmt -m=100 ./src/...
.PHONY: lint

## todo: prints the list of todos in the code
todo:
	grep -rn 'TODO' ./

## test: test everything
test:
	go test -race -v -count 1 ./...
