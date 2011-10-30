LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE    := prebuild-FlashRuntimeExtensions
LOCAL_SRC_FILES := external/lib/FlashRuntimeExtensions.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := AneLab-CameraBitmapReverse-NDK
LOCAL_SRC_FILES := AneLab-CameraBitmapReverse-NDK.c.arm
LOCAL_SHARED_LIBRARIES := prebuild-FlashRuntimeExtensions
LOCAL_C_INCLUDES       := external/include
include $(BUILD_SHARED_LIBRARY)
