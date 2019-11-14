ARCHS = arm64 arm64e armv7 armv7s
TARGET = iphone:clang:11.2:7.0
DEBUG = 0
GO_EASY_ON_ME = 1
#THEOS_PACKAGE_DIR_NAME = debs
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SnoverlayCustomizer
SnoverlayCustomizer_FILES = Tweak.xm
SnoverlayCustomizer_FRAMEWORKS = UIKit Foundation QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += SnoverlayCustomizer
include $(THEOS_MAKE_PATH)/aggregate.mk
