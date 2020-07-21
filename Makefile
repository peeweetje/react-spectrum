.PHONY: clean build

SHELL := /bin/bash
PATH := ./node_modules/.bin:$(PATH)

adobe_setup:
	mkdir packages/dev/v2-test-deps
	cp scripts/v2-package.json packages/dev/v2-test-deps/package.json

clean:
	yarn clean:icons
	rm -rf dist storybook-static storybook-static-v3 public src/dist

clean_all:
	$(MAKE) clean
	$(MAKE) clean_node_modules

clean_node_modules:
	rm -rf node_modules
	rm -rf packages/*/*/node_modules

publish: build
	lerna publish from-package --yes

build:
	parcel build packages/@react-{spectrum,aria,stately}/*/ --no-minify

website:
	yarn build:docs --public-url /reactspectrum/$$(git rev-parse HEAD)/docs --dist-dir dist/$$(git rev-parse HEAD)/docs

website-production:
	node scripts/buildWebsite.js
	cp packages/dev/docs/pages/robots.txt dist/production/docs/robots.txt
