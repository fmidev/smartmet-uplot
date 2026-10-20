SPEC = smartmet-uplot

# Only the spec is stored in this repository. The source tarball is downloaded
# next to it from the URL in the spec.

RPMBUILD = rpmbuild --define "_sourcedir $(CURDIR)"

# Installation directories for 'make install' (same layout as the RPM)
PREFIX ?= /usr
DATADIR ?= $(PREFIX)/share
INSTALLDIR = $(DESTDIR)$(DATADIR)/smartmet/uplot
LICENSEDIR = $(DESTDIR)$(DATADIR)/licenses/$(SPEC)

FILES = dist/uPlot.iife.min.js dist/uPlot.min.css
LICENSES = LICENSE

.PHONY: all sources srpm rpm unpack install clean

all:
	@echo "Use 'make rpm' to download the sources and build the RPM package."

# rpmspec comes with rpm-build; spectool (rpmdevtools) is not available in the CI images
sources:
	url=$$(rpmspec -P $(SPEC).spec | awk '/^Source0:/ {print $$2}'); \
	file=$$(basename $$url); \
	test -s $$file || curl --fail --silent --show-error --location --output $$file $$url

srpm: sources
	$(RPMBUILD) -bs $(SPEC).spec

rpm: sources
	$(RPMBUILD) -ba $(SPEC).spec

# Unpack the installed file set into ./dist for running explorer tests without
# installing the RPM (point api_catalog.uplot_dir at it).
unpack: sources
	rm -rf dist package
	tar -xzf uplot-*.tgz
	mkdir -p dist
	cp $(addprefix package/,$(FILES)) dist/
	rm -rf package

# Install the same file set as the RPM directly, without building a package.
# Supports DESTDIR and PREFIX, e.g. 'make install DESTDIR=/tmp/root'.
install: sources
	rm -rf package
	tar -xzf uplot-*.tgz
	install -d $(INSTALLDIR) $(LICENSEDIR)
	install -m 0644 $(addprefix package/,$(FILES)) $(INSTALLDIR)/
	install -m 0644 $(addprefix package/,$(LICENSES)) $(LICENSEDIR)/
	rm -rf package

clean:
	rm -rf *.tgz dist package
