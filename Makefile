VERSION = 1.0
BUILD = 1

all:
	make -C usr/src/cmd -f Makefile.linux

memcheck:
	make -C usr/src/cmd -f Makefile.linux memcheck

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
	rm -rf onnv-linux-$(VERSION)
	rm -rf onnv-linux-$(VERSION).tar.gz
	rm -rf onnv-linux-$(VERSION).zip
