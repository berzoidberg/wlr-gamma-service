INSTALL_PATH?=/usr/local
WAYLAND_SCANNER=$(shell pkg-config --variable=wayland_scanner wayland-scanner)
LIBS=\
	$(shell pkg-config --cflags --libs wlroots) \
	$(shell pkg-config --cflags --libs wayland-client) \
	$(shell pkg-config --cflags --libs xkbcommon) \
	$(shell pkg-config --cflags --libs gio-2.0 gio-unix-2.0 glib-2.0) \
	-lm

out/wlr-gamma-service: out \
	src/wlrgammasvc.c \
	src/color_math.c \
	src/color_math.h \
	gen/wlr-gamma-control-unstable-v1-client-protocol.h \
	gen/wlr-gamma-control-unstable-v1-client-protocol.c \
	gen/wlrgammasvcbus.h \
	gen/wlrgammasvcbus.c
	$(CC) $(CFLAGS) \
		-I. -Werror -DWLR_USE_UNSTABLE \
		$(LIBS) \
		-o $@ \
		src/wlrgammasvc.c \
		gen/wlr-gamma-control-unstable-v1-client-protocol.c \
	  	gen/wlrgammasvcbus.c \
		src/color_math.c

gen/wlr-gamma-control-unstable-v1-client-protocol.h: gen
	$(WAYLAND_SCANNER) client-header \
		vendor/wlr-protocols/unstable/wlr-gamma-control-unstable-v1.xml $@

gen/wlr-gamma-control-unstable-v1-client-protocol.c: gen 
	$(WAYLAND_SCANNER) private-code \
		vendor/wlr-protocols/unstable/wlr-gamma-control-unstable-v1.xml $@

gen/wlrgammasvcbus.c gen/wlrgammasvcbus.h: gen
	gdbus-codegen --output-directory gen --generate-c-code wlrgammasvcbus \
		--c-namespace WlrGammaSvcBus --interface-prefix net.zoidplex. \
		res/net.zoidplex.wlr_gamma_service.xml

gen:
	mkdir -p gen

out:
	mkdir -p out

install:
	install -Dm755 out/wlrgammasvc $(INSTALL_PATH)/bin/wlrgammasvc

clean:
	rm -rf out gen

.PHONY: clean
