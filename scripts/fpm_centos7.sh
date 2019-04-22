# generated using docker-fpm repo

#Currently fpm is failing due to special characters in some of the rom filenames.. sigh..

docker run -v "$(pwd):/src/" fpmcentos7:latest fpm -s dir -t rpm --depends xscreensaver --depends libsdl2-2.0-0 --depends libsdl2-image-2.0-0 --depends libsdl2-ttf-2.0-0 -n msxsaver --license MPL2 --maintainer "Ray Burgemeestre <ray@cppse.nl>" --description "MSXSaver - An MSX Game Intros Screensaver for XScreenSaver" --url "https://cppse.nl/msxsaver" -C /src/out

