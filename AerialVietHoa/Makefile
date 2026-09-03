TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME = rootless

# Tweak chạy trên SpringBoard (Màn hình chính)
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AerialVietHoa

AerialVietHoa_FILES = Tweak.x
AerialVietHoa_CFLAGS = -fobjc-arc
# Bắt buộc có dòng này vì hook vào UILabel (UIKit)
AerialVietHoa_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
