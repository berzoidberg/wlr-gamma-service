#!/bin/bash
gdbus call -e -d net.zoidplex.wlr_gamma_service -o /net/zoidplex/wlr_gamma_service -m net.zoidplex.wlr_gamma_service.brightness.set $1 | cut -d "(" -f2 | cut -d "," -f1 | awk '{print $1*100}' > $SWAYSOCK.wob
