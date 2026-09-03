TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME = rootless

INSTALL_TARGET_PROCESSES = Aweme

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DouyinJTISVN

DouyinJTISVN_FILES = Tweak.x
DouyinJTISVN_CFLAGS = -fobjc-arc
DouyinJTISVN_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
