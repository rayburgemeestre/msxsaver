# generated using docker-fpm repo
docker run -v "$(pwd):/src/" fpm:latest fpm -s dir -t deb --depends xscreensaver --depends libsdl2-2.0-0 --depends libsdl2-image-2.0-0 --depends libsdl2-ttf-2.0-0 -n msxsaver --license MPL2 --maintainer "Ray Burgemeestre <ray@cppse.nl>" --description "MSXSaver - An MSX Game Intros Screensaver for XScreenSaver" --url "https://cppse.nl/msxsaver" --deb-generate-changes -C /src/out


