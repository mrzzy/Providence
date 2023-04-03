#
# Providence
# Makefile
#

.PHONY := all fmt lint
.DEFAULT_GOAL := all


all: fmt lint build test

# SimplyGo source
SIMPLYGO_DIR := sources/simplygo

define SIMPLYGO_RULE
.PHONY += $(1)-simplygo
$(1): $(1)-simplygo
$(1)-simplygo: $$(SIMPLYGO_DIR)
	cd $$< && $(2)
endef

$(eval $(call SIMPLYGO_RULE,fmt,cargo fmt))
$(eval $(call SIMPLYGO_RULE,lint,cargo fmt --check && cargo clippy))
$(eval $(call SIMPLYGO_RULE,build,cargo build))
$(eval $(call SIMPLYGO_RULE,test,cargo test))

# Airflow Pipelines
PIPELINES_DIR := pipelines

fmt: fmt-pipelines

fmt-pipelines: $(PIPELINES_DIR)
	black $<

lint: lint-pipelines

lint-pipelines: $(PIPELINES_DIR)
	black --check $<

test: test-pipelines

test-pipelines: $(PIPELINES_DIR)
	cd $< && pytest
