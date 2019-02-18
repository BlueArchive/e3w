include ../../Makefile.vars

N_ENV=export N_PREFIX="$(HOME)/n" ; export PATH=$(PATH):$(HOME)/n/bin;
NODE_VERSION=8.11.1

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
	$(N_ENV) n $(NODE_VERSION)
	cd static && $(N_ENV) npm install && npm run publish