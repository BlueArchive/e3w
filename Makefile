include ../../Makefile.vars

APP=$(BIN_DIR)/e3w
PAGES=static/dist/bundle.js
CONTAINER_SRC=Dockerfile $(APP) $(PAGES) Makefile conf/config.default.ini
DOCKER_BUILD_EXTRAS=--no-cache
include ../../Makefile.common

build: $(APP) $(PAGES)

$(APP): $(GO_SOURCES) Makefile
	$(GO_BUILD_PRODUCTION_STATIC_NO_CGO) -o $@ ./main.go

$(PAGES): Makefile static/src/* static/package-lock.json static/package.json static/webpack.config.js
	echo due $?
	cd static && npm install && npm run publish