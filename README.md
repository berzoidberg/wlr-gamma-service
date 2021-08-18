# wlr-gamma-service

A fork of [wlr-brightness](https://github.com/mherzberg/wlr-brightness), adding color temperature controls courtesy of color math functions from the [wlsunset](mherzberg/wlr-brightness)

wlr-gamma-service adjust the brightness and color temperature of your screen when using
[wlroots](https://github.com/swaywm/wlroots/)-based
[Wayland](https://wayland.freedesktop.org/) compositors such as
[sway](https://github.com/swaywm/sway/). It works by adjusting the gamma values
of your screen and therefore supports both screens with and without backlight
(such as OLED).

## Installation

### From Source

Dependencies:

* [wlroots](https://github.com/swaywm/wlroots)
* wayland
* dbus
* wlr-protocols

Pull wlr-protocols:

    git submodule update --init --recursive

Compile:

    make
    
If you want to install wlr-gamma-service, you can use the systemd service:

    sudo make install
    cp res/wlr-gamma-service.service ~/.config/systemd/user/
    systemd --user enable --now wlr-gamma-service.service

## Usage

Start the daemon:

    wlr-gamma-service

wlr-gamma-service is a Wayland-client and therefore needs to keep running. The
brightness and temperature will reset to the defaults on exit. To control wlr-gamma-service, use any
dbus utility, e.g.:

    gdbus call -e -d net.zoidplex -o /net/zoidplex/wlr_gamma_service -m net.zoidplex.wlr_gamma_service.get_brightness
    gdbus call -e -d net.zoidplex -o /net/zoidplex/wlr_gamma_service -m net.zoidplex.wlr_gamma_service.set_brightness 0.7
    gdbus call -e -d net.zoidplex -o /net/zoidplex/wlr_gamma_service -m net.zoidplex.wlr_gamma_service.increase_brightness 0.1
    gdbus call -e -d net.zoidplex -o /net/zoidplex/wlr_gamma_service -m net.zoidplex.wlr_gamma_service.decrease_brightness 0.1
    gdbus call -e -d net.zoidplex -o /net/zoidplex/wlr_gamma_service -m net.zoidplex.wlr_gamma_service.get_temperature
    gdbus call -e -d net.zoidplex -o /net/zoidplex/wlr_gamma_service -m net.zoidplex.wlr_gamma_service.set_temperature 4000
    gdbus call -e -d net.zoidplex -o /net/zoidplex/wlr_gamma_service -m net.zoidplex.wlr_gamma_service.increase_temperature 100
    gdbus call -e -d net.zoidplex -o /net/zoidplex/wlr_gamma_service -m net.zoidplex.wlr_gamma_service.decrease_tempeature 100
