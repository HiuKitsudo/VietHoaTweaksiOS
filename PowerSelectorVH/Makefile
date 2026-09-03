TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME = rootless

# Không cần dòng INSTALL_TARGET_PROCESSES vì ta đã lọc trong plist rồi

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PowerSelectorVH

PowerSelectorVH_FILES = Tweak.x
PowerSelectorVH_CFLAGS = -fobjc-arc
# Bắt buộc có dòng này
PowerSelectorVH_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
