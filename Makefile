# Copyright 2022 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.PHONY: all

# build info
VERSION=$(shell git describe --tags --always --long)
LDFLAGS="-X main.version=$(VERSION)"
ARCH="amd64"
BUILD_DIR="windows-service-proxy"
PLATFORM="windows"

# Auto Generate help from: https://gist.github.com/prwhite/8168133
# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)
TARGET_MAX_CHAR_NUM=20

build:
	@mkdir -p $(BUILD_DIR)/$(PLATFORM)/$(VERSION)
	@cd cmd && \
		env GOOS=$(PLATFORM) \
		GOARCH=$(ARCH) \
		go build \
		-trimpath \
		-o ../$(BUILD_DIR)/$(PLATFORM)/$(VERSION) \
		-v \
		-ldflags=$(LDFLAGS) \
		./...
	@echo "\t$(YELLOW)windows-service-proxy$(RESET) binaries available in: $(GREEN)$(BUILD_DIR)/$(PLATFORM)/$(VERSION)$(RESET)\n"
