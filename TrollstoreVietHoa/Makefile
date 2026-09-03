TARGET := iphone:clang:latest:15.0
THEOS_PACKAGE_SCHEME = rootless
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TrollStoreVietHoa

TrollStoreVietHoa_FILES = Tweak.x
TrollStoreVietHoa_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
