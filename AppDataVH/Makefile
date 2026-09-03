TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME = rootless

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AppDataVH

AppDataVH_FILES = Tweak.x
AppDataVH_CFLAGS = -fobjc-arc

AppDataVH_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk