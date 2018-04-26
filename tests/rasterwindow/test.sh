#!/bin/sh

MYDIR=$(dirname $0)

#export QT_DEBUG_PLUGINS=1
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM_PLUGIN_PATH=$(dirname $0)/../../qt5ct/src/qt5ct-qtplugin
gdb $(dirname $0)/rasterwindow
