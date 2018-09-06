VERSION = 1.0

all:
	make -C usr/src/cmd -f Makefile.linux

tarball: clean
	mkdir onnv-linux-$(VERSION)
	cp -R usr onnv-linux-$(VERSION)/usr
	tar cvfz onnv-linux-$(VERSION).tar.gz onnv-linux-$(VERSION)

zipfile: clean
	mkdir onnv-linux-$(VERSION)
	cp -R usr onnv-linux-$(VERSION)/usr
	zip -r onnv-linux-$(VERSION).zip onnv-linux-$(VERSION)

clean:
	make -C usr/src/cmd -f Makefile.linux clean
	rm -rf onnv-linux-$(VERSION)
	rm -rf onnv-linux-$(VERSION).tar.gz
	rm -rf onnv-linux-$(VERSION).zip
