
build:
	docker run -t -v $$PWD:$$PWD --workdir $$PWD rayburgemeestre/build-ubuntu:18.04 /bin/sh -c "make containerized-build"
	make package

containerized-build:
	make prepare
	make gobuild
	make archive

prepare:
	apt-get update
	apt-get install -y pkg-config
	apt-get install -y xscreensaver libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev
	cd / && \
	wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && \
	tar -zxvf go1.13.5.linux-amd64.tar.gz

gobuild:
	#cd gogame && \
	#PATH=$$PATH:/go/bin GOFLAGS=-mod=vendor CGO_ENABLED=1 go build
	cd gomsx && \
	PATH=$$PATH:/go/bin GOFLAGS=-mod=vendor CGO_ENABLED=1 go build

archive:
	rm -rf out
	mkdir -p out/usr/local/bin
	mkdir -p out/usr/share/msxsaver
	cp -prv cf-2700_basic-bios1.rom    out/usr/share/msxsaver/
	cp -prv games.txt                  out/usr/share/msxsaver/
	cp -prv Monaco_Linux-Powerline.ttf out/usr/share/msxsaver/
	cp -prv softwaredb.xml             out/usr/share/msxsaver/
	cp -prv roms                       out/usr/share/msxsaver/
	cp -prv .xscreensaver              out/usr/share/msxsaver/
	cp -prv gomsx/gomsx                out/usr/local/bin/msxsaver

package:
	rm -rf msxsaver_1.0_amd64.deb
	mkdir -p out
	docker run -v "$$PWD:$$PWD" --workdir "$$PWD" rayburgemeestre/fpm-ubuntu:18.04 fpm -s dir -t deb --depends xscreensaver --depends libsdl2-2.0-0 --depends libsdl2-image-2.0-0 --depends libsdl2-ttf-2.0-0 -n msxsaver --license MPL2 --maintainer "Ray Burgemeestre <ray@cppse.nl>" --description "MSXSaver - An MSX Game Intros Screensaver for XScreenSaver" --url "https://cppse.nl/msxsaver" --deb-generate-changes -C ./out

shell:
	docker run -it -v $$PWD:$$PWD --workdir $$PWD rayburgemeestre/build-ubuntu:18.04 /bin/bash
