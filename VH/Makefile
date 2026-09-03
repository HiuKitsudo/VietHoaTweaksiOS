TARGET := iphone:clang:latest:latest

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = AppStorePlusVH

AppStorePlusVH_FILES = AppStorePlusVH.xm
AppStorePlusVH_CFLAGS = -fobjc-arc
AppStorePlusVH_INSTALL_PATH = /usr/local/lib
AppStorePlusVH_FRAMEWORKS = UIKit Foundation
AppStorePlusVH_LDFLAGS = -lobjc

include $(THEOS_MAKE_PATH)/library.mk

