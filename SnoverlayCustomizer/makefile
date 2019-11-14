ARCHS = arm64 arm64e armv7 armv7s
TARGET = iphone:clang:11.2:7.0
GO_EASY_ON_ME = 1
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SnoverlayCustomizer
SnoverlayCustomizer_FILES = PFHeaderCell.mm SnoverlayCustomizer.mm 
SnoverlayCustomizer_INSTALL_PATH = /Library/PreferenceBundles
SnoverlayCustomizer_FRAMEWORKS = UIKit
SnoverlayCustomizer_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SnoverlayCustomizer.plist$(ECHO_END)
