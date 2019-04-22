This project modified the MSX emulator written in go by Pere Negre (pnegre)
called `gomsx` (https://github.com/pnegre/gomsx) into something that runs as
one of XScreenSaver's programs.

So all credits to him, my work is just a bunch of hacks on top of his emulator!

* Changes to `gogame`: https://github.com/pnegre/gogame/compare/master...rayburgemeestre:master
* Changes to `gomsx`: https://github.com/pnegre/gomsx/compare/master...rayburgemeestre:screensaver

XScreenSaver (https://www.jwz.org/xscreensaver/) is AFAIK one of the oldest and
most widespread screensaver daemons available on Linux. It contains all the
logic regarding creating Full Screen windows on top of everything, making sure
your session is locked, handing multiple screens, etc. For these reasons I
decided to depend on it for this project.

One default I changed is that now the base system is running an MSX1 Panasonic
CF-2700.

## Installation on Ubuntu

The package should be available on all currently supported Ubuntu distributions.

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 29CB5B50
    sudo add-apt-repository "deb https://cppse.nl/apt/ $(lsb_release -cs) main"

(The reason I'm not using a PPA is due to the fact that I create the package using FPM
and this is currently not supported in combination with PPA's.)

In case lsb-release or add-apt-repository is missing, install first:

    apt install lsb-release software-properties-common

## Installing from Source (deprecated)

Checkout this repository to `$HOME/.msxsaver`.

    git clone https://github.com/rayburgemeestre/msxsaver ~/.msxsaver

Refer to the Compiling section for compiling gomsx yourself, the binary shipped
is 64bit Linux.

You may need the following dependencies (packages may differ on your system)

    xscreensaver
    libsdl2-dev
    libsdl2-image-dev
    libsdl2-ttf-dev

(Something for X11 might be needed, but probably xscreensaver already pulled everything in.)

Test if it works with:

    cd ~/.msxsaver
    ./gomsx

No parameters are needed, use `CTRL`+`C` on the graphical window to exit. In
case it doesn't work, you can check for hints by running `ldd gomsx`, some
library may be missing.

## Configuring XScreenSaver

First you need to have the xscreensaver daemon running. In my case I run the i3
window manager, so I have this line in my config:

    exec --no-startup-id xscreensaver -nosplash

This starts the daemon, also for convenience I have an alias to trigger lock:

    bindsym $mod+Control+Shift+l exec /usr/bin/xscreensaver-command -lock

The easiest way to add the gomsx screensaver is probably to run:

    xscreensaver-command -prefs

And go to Display Modes -> Mode (select "Only One Screen Saver"). Set cycle
after to `0`, since the screensaver cycles by itself every minute.

Then close the dialog and edit `~/.xscreensaver`, the important section is
`programs`:

    programs:                                           \
      GL:               /home/trigen/.msxsaver/gomsx    \
                      1>/tmp/msxsaver-debug.log 2>&1    \n\

Please note that `$HOME` or `~/` doesn't work in this file!

Probably there are lots of other programs listed, but as long as they are
commented out using the minus sign gomsx should be the only one launched.

For reference some other "key" settings IMO from my .xscreensaver file:

    timeout:        0:01:00
    cycle:          0:00:00
    lock:           True
    lockTimeout:    0:01:00
    passwdTimeout:  0:00:10

## Files and directories in `~/.msxsaver`

- `cf-2700_basic-bios1.rom` - MSX1 system
- `games.txt` - List of games that I confirmed to work with this emulator.
- `gomsx*` - The 64bit precompiled binary, should run on at least Ubuntu 18.04
  64bit Linux. If it does not run on your system, please compile it with
  instructions in the Compiling section and replace the `gomsx` binary with the
  one you compiled yourself.
- `Monaco_Linux-Powerline.ttf` - Font I use for printing which rom is active.
- `README.md` - This file
- `roms/` - Directory that contains all the games referred to by `games.txt`
- `softwaredb.xml` - The Software DB that can help loading games.

It is possible to curate your own preferred list of games by editing games.txt.
They are organized per category.
It was a hell of a job to filter out 218 games that didn't work :)

## Compiling `gomsx` manually

    git submodule update --init --recursive

    cd gomsx
    go build  # version that supports go mod is needed!
    cp gomsx ../msxsaver

