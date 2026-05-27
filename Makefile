export THEOS ?= /Users/tune/Develop/theos-roothide

TARGET := iphone:clang:latest:14.0
THEOS_PACKAGE_SCHEME ?= roothide
ARCHS := arm64 arm64e

INSTALL_TARGET_PROCESSES := MobileSlideShow Camera

include $(THEOS)/makefiles/common.mk

TWEAK_NAME := PhotoZoomSkip

PhotoZoomSkip_FILES := Tweak.xm
PhotoZoomSkip_CFLAGS := -fno-objc-arc
PhotoZoomSkip_FRAMEWORKS := Foundation
PhotoZoomSkip_LIBRARIES := substrate

include $(THEOS_MAKE_PATH)/tweak.mk
