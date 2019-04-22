rm -rf out
rm -rf msxsaver_1.0_amd64.deb

mkdir -p out/usr/local/bin
mkdir -p out/usr/share/msxsaver

cp -prv cf-2700_basic-bios1.rom    out/usr/share/msxsaver/
cp -prv games.txt                  out/usr/share/msxsaver/
cp -prv Monaco_Linux-Powerline.ttf out/usr/share/msxsaver/
cp -prv softwaredb.xml             out/usr/share/msxsaver/
cp -prv roms                       out/usr/share/msxsaver/
cp -prv .xscreensaver              out/usr/share/msxsaver/

cp -prv gomsx                      out/usr/local/bin/msxsaver

bash fpm.sh
