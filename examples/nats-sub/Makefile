LINUX = CGO_ENABLED=0 GOOS=linux GODEBUG=netdns=1
DARWIN = CGO_ENABLED=0 GOOS=darwin
WINDOWS = CGO_ENABLED=0 GOOS=windows
BIN = $(GOPATH)/bin
GOLINT = $(BIN)/golint
APPBIN = $(shell basename `pwd`)
DATE = $(shell date +%FT%T%z)
COMMIT = $(shell git rev-parse --short HEAD)
VERSION = $(shell git describe --tags --always --dirty)
DOCKERTAG= $(shell echo $(VERSION) | sed 's/.*dirty/dev/g'| sed 's/.*-.*/dev/g' )
DOCKERREPO = registry.gitlab.com/uhn/uhn
LDFLAG 	 = "-s -w \
-X gitlab.com/uhn/core/pkg/app.version=$(VERSION) \
-X gitlab.com/uhn/core/pkg/app.builddate=$(DATE) \
-X gitlab.com/uhn/core/pkg/app.commit=$(COMMIT)"

V = 0
Q = $(if $(filter 1,$V),,@)
DQ = $(if $(filter 1,$V),,--quiet)
I = $(if $(filter 1,$(INDENT)),\t,)
I2 = $(if $(filter 2,$(INDENT)),\t\t,)
I3 = $(if $(filter 3,$(INDENT)),\t\t\t,)
M = $(shell printf "$(I)$(I2)$(I3)\033[34;1m▶\033[0m")
O =

RELDIR=$(shell git rev-parse --show-toplevel)/release

all: fmt docker

$(BIN)/golint: ; $(info Building golint)
	$Q go get -v github.com/golang/lint/golint

fmt: ; $(info Formatting code)
	$Q gofmt -l -w *.go

lint: $(GOLINT) ; $(info Linting code)
	$Q $(GOLINT) -min_confidence 0.9 *.go

echo: ; $(info $M $(RELDIR1) )

clean:
	$Q rm -f $(RELDIR)/linux/$(APPBIN)
	$Q rm -f $(RELDIR)/darwin/$(APPBIN)
	$Q rm -f $(RELDIR)/win10/$(APPBIN)

build: build-linux build-darwin build-win10

build-linux: $(RELDIR)/linux/$(APPBIN); $(info $M Building $(APPBIN) for linux.)
$(RELDIR)/linux/$(APPBIN):
	$Q $(LINUX) go build -ldflags $(LDFLAG) -a -installsuffix nocgo -o $@ *go

build-darwin: $(RELDIR)/darwin/$(APPBIN); $(info $M Building $(APPBIN) for darwin.)
$(RELDIR)/darwin/$(APPBIN):
	$Q $(DARWIN) go build -ldflags $(LDFLAG) -a -installsuffix nocgo -o $@ *go

build-win10: $(RELDIR)/win10/$(APPBIN); $(info $M Building $(APPBIN) for windows.)
$(RELDIR)/win10/$(APPBIN):
	$Q $(WINDOWS) go build -ldflags $(LDFLAG) -a -installsuffix nocgo -o $@ *go

docker: $(RELDIR)/linux/$(APPBIN) ; $(info $M Adding $(APPBIN) to docker image)
	$Q cp $(RELDIR)/linux/$(APPBIN) . 
	$Q docker build --network host $(if $(filter 1,$V),,--quiet) -t $(APPBIN):$(COMMIT) . >/dev/null
	$Q rm $(APPBIN)

.PHONY: all
