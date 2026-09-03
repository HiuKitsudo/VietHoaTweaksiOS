TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = Preferences
ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RainMhzVH

RainMhzVH_FILES = Tweak.x
RainMhzVH_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
