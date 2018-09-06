VERSION = 1.0
BUILD = 1
current_dir = $(shell pwd)

all:
	make -C usr/src/cmd -f Makefile.linux

memcheck:
	make -C usr/src/cmd -f Makefile.linux memcheck

test:
	make -C usr/src/cmd -f Makefile.linux install DESTDIR=$(current_dir)/test
	make -C test all

install:
	make -C usr/src/cmd -f Makefile.linux install

rpm: tarball
	mkdir rpm
	rpmbuild --define "_topdir `pwd`/rpm" --define "build_num $(BUILD)" -ta onnv-linux-$(VERSION).tar.gz

tarball: clean
	mkdir onnv-linux-$(VERSION)
	cp -R usr onnv-linux-$(VERSION)/usr
	cp onnv.spec onnv-linux-$(VERSION)/onnv-linux.spec
	tar cvfz onnv-linux-$(VERSION).tar.gz onnv-linux-$(VERSION)

zipfile: clean
	mkdir onnv-linux-$(VERSION)
	cp -R usr onnv-linux-$(VERSION)/usr
	zip -r onnv-linux-$(VERSION).zip onnv-linux-$(VERSION)

clean:
	make -C usr/src/cmd -f Makefile.linux clean
	rm -rf rpm
	rm -rf test/bin
	rm -rf onnv-linux-$(VERSION)
	rm -rf onnv-linux-$(VERSION).tar.gz
	rm -rf onnv-linux-$(VERSION).zip

.PHONY: test
