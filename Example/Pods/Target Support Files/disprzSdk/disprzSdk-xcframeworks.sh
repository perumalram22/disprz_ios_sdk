#!/bin/sh
set -e
set -u
set -o pipefail

function on_error {
  echo "$(realpath -mq "${0}"):$1: error: Unexpected failure"
}
trap 'on_error $LINENO' ERR


# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")


variant_for_slice()
{
  case "$1" in
  "Base64.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "Base64.xcframework/ios-arm64")
    echo ""
    ;;
  "BVLinearGradient.xcframework/ios-arm64")
    echo ""
    ;;
  "BVLinearGradient.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "CodePush.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "CodePush.xcframework/ios-arm64")
    echo ""
    ;;
  "CoreModules.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "CoreModules.xcframework/ios-arm64")
    echo ""
    ;;
  "cxxreact.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "cxxreact.xcframework/ios-arm64")
    echo ""
    ;;
  "DisprzSdk.xcframework/ios-x86_64-simulator")
    echo "simulator"
    ;;
  "DisprzSdk.xcframework/ios-arm64")
    echo ""
    ;;
  "DoubleConversion.xcframework/ios-arm64")
    echo ""
    ;;
  "DoubleConversion.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "FBReactNativeSpec.xcframework/ios-arm64")
    echo ""
    ;;
  "FBReactNativeSpec.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "folly.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "folly.xcframework/ios-arm64")
    echo ""
    ;;
  "glog.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "glog.xcframework/ios-arm64")
    echo ""
    ;;
  "jsi.xcframework/ios-arm64")
    echo ""
    ;;
  "jsi.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "jsinspector.xcframework/ios-arm64")
    echo ""
    ;;
  "jsinspector.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "jsireact.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "jsireact.xcframework/ios-arm64")
    echo ""
    ;;
  "JWT.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "JWT.xcframework/ios-arm64")
    echo ""
    ;;
  "libwebp.xcframework/ios-arm64")
    echo ""
    ;;
  "libwebp.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "Pods_DisprzSdk.xcframework/ios-arm64")
    echo ""
    ;;
  "Pods_DisprzSdk.xcframework/ios-x86_64-simulator")
    echo "simulator"
    ;;
  "RCTAnimation.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTAnimation.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTBlob.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTBlob.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTImage.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTImage.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTLinking.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTLinking.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTNetwork.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTNetwork.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTSettings.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTSettings.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTText.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTText.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTTypeSafety.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTTypeSafety.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTVibration.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTVibration.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTYouTube.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTYouTube.xcframework/ios-arm64")
    echo ""
    ;;
  "React.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "React.xcframework/ios-arm64")
    echo ""
    ;;
  "ReactCommon.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "ReactCommon.xcframework/ios-arm64")
    echo ""
    ;;
  "ReactNativeART.xcframework/ios-arm64")
    echo ""
    ;;
  "ReactNativeART.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_camera.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_camera.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_config.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_config.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_device_brightness.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_device_brightness.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_document_picker.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_document_picker.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_geolocation.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_geolocation.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_image_picker.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_image_picker.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_keep_awake.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_keep_awake.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_maps.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_maps.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_music_control.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_music_control.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_netinfo.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_netinfo.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_orientation.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_orientation.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_photo_view.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_photo_view.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_safe_area_context.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_safe_area_context.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_secure_window.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_secure_window.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_slider.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_slider.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_splash_screen.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_splash_screen.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_video.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_video.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_voice.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_voice.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "react_native_webview.xcframework/ios-arm64")
    echo ""
    ;;
  "react_native_webview.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNAudio.xcframework/ios-arm64")
    echo ""
    ;;
  "RNAudio.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNCAsyncStorage.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNCAsyncStorage.xcframework/ios-arm64")
    echo ""
    ;;
  "RNCMaskedView.xcframework/ios-arm64")
    echo ""
    ;;
  "RNCMaskedView.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNDeviceInfo.xcframework/ios-arm64")
    echo ""
    ;;
  "RNDeviceInfo.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNFastImage.xcframework/ios-arm64")
    echo ""
    ;;
  "RNFastImage.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNFS.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNFS.xcframework/ios-arm64")
    echo ""
    ;;
  "RNGestureHandler.xcframework/ios-arm64")
    echo ""
    ;;
  "RNGestureHandler.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNI18n.xcframework/ios-arm64")
    echo ""
    ;;
  "RNI18n.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNInAppBrowser.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNInAppBrowser.xcframework/ios-arm64")
    echo ""
    ;;
  "RNReanimated.xcframework/ios-arm64")
    echo ""
    ;;
  "RNReanimated.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNScreens.xcframework/ios-arm64")
    echo ""
    ;;
  "RNScreens.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNSnackbar.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNSnackbar.xcframework/ios-arm64")
    echo ""
    ;;
  "RNSound.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNSound.xcframework/ios-arm64")
    echo ""
    ;;
  "RNSVG.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNSVG.xcframework/ios-arm64")
    echo ""
    ;;
  "RNVectorIcons.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNVectorIcons.xcframework/ios-arm64")
    echo ""
    ;;
  "rn_fetch_blob.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "rn_fetch_blob.xcframework/ios-arm64")
    echo ""
    ;;
  "SDWebImage.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "SDWebImage.xcframework/ios-arm64")
    echo ""
    ;;
  "SDWebImageWebPCoder.xcframework/ios-arm64")
    echo ""
    ;;
  "SDWebImageWebPCoder.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "SSZipArchive.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "SSZipArchive.xcframework/ios-arm64")
    echo ""
    ;;
  "toolbar_android.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "toolbar_android.xcframework/ios-arm64")
    echo ""
    ;;
  "yoga.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "yoga.xcframework/ios-arm64")
    echo ""
    ;;
  "YoutubePlayer_in_WKWebView.xcframework/ios-arm64")
    echo ""
    ;;
  "YoutubePlayer_in_WKWebView.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  esac
}

archs_for_slice()
{
  case "$1" in
  "Base64.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "Base64.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "BVLinearGradient.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "BVLinearGradient.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "CodePush.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "CodePush.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "CoreModules.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "CoreModules.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "cxxreact.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "cxxreact.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "DisprzSdk.xcframework/ios-x86_64-simulator")
    echo "x86_64"
    ;;
  "DisprzSdk.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "DoubleConversion.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "DoubleConversion.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "FBReactNativeSpec.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "FBReactNativeSpec.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "folly.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "folly.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "glog.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "glog.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "jsi.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "jsi.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "jsinspector.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "jsinspector.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "jsireact.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "jsireact.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "JWT.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "JWT.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "libwebp.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "libwebp.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "Pods_DisprzSdk.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "Pods_DisprzSdk.xcframework/ios-x86_64-simulator")
    echo "x86_64"
    ;;
  "RCTAnimation.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTAnimation.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTBlob.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTBlob.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTImage.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTImage.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTLinking.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTLinking.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTNetwork.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTNetwork.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTSettings.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTSettings.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTText.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTText.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTTypeSafety.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTTypeSafety.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTVibration.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTVibration.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTYouTube.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTYouTube.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "React.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "React.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "ReactCommon.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "ReactCommon.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "ReactNativeART.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "ReactNativeART.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_camera.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_camera.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_config.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_config.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_device_brightness.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_device_brightness.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_document_picker.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_document_picker.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_geolocation.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_geolocation.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_image_picker.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_image_picker.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_keep_awake.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_keep_awake.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_maps.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_maps.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_music_control.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_music_control.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_netinfo.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_netinfo.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_orientation.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_orientation.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_photo_view.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_photo_view.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_safe_area_context.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_safe_area_context.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_secure_window.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_secure_window.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_slider.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_slider.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_splash_screen.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_splash_screen.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_video.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_video.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_voice.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_voice.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "react_native_webview.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "react_native_webview.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNAudio.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNAudio.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNCAsyncStorage.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNCAsyncStorage.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNCMaskedView.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNCMaskedView.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNDeviceInfo.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNDeviceInfo.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNFastImage.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNFastImage.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNFS.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNFS.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNGestureHandler.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNGestureHandler.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNI18n.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNI18n.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNInAppBrowser.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNInAppBrowser.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNReanimated.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNReanimated.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNScreens.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNScreens.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNSnackbar.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNSnackbar.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNSound.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNSound.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNSVG.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNSVG.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNVectorIcons.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNVectorIcons.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "rn_fetch_blob.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "rn_fetch_blob.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "SDWebImage.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "SDWebImage.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "SDWebImageWebPCoder.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "SDWebImageWebPCoder.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "SSZipArchive.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "SSZipArchive.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "toolbar_android.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "toolbar_android.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "yoga.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "yoga.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "YoutubePlayer_in_WKWebView.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "YoutubePlayer_in_WKWebView.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  esac
}

copy_dir()
{
  local source="$1"
  local destination="$2"

  # Use filter instead of exclude so missing patterns don't throw errors.
  echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" --links --filter \"- CVS/\" --filter \"- .svn/\" --filter \"- .git/\" --filter \"- .hg/\" \"${source}*\" \"${destination}\""
  rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" --links --filter "- CVS/" --filter "- .svn/" --filter "- .git/" --filter "- .hg/" "${source}"/* "${destination}"
}

SELECT_SLICE_RETVAL=""

select_slice() {
  local xcframework_name="$1"
  xcframework_name="${xcframework_name##*/}"
  local paths=("${@:2}")
  # Locate the correct slice of the .xcframework for the current architectures
  local target_path=""

  # Split archs on space so we can find a slice that has all the needed archs
  local target_archs=$(echo $ARCHS | tr " " "\n")

  local target_variant=""
  if [[ "$PLATFORM_NAME" == *"simulator" ]]; then
    target_variant="simulator"
  fi
  if [[ ! -z ${EFFECTIVE_PLATFORM_NAME+x} && "$EFFECTIVE_PLATFORM_NAME" == *"maccatalyst" ]]; then
    target_variant="maccatalyst"
  fi
  for i in ${!paths[@]}; do
    local matched_all_archs="1"
    local slice_archs="$(archs_for_slice "${xcframework_name}/${paths[$i]}")"
    local slice_variant="$(variant_for_slice "${xcframework_name}/${paths[$i]}")"
    for target_arch in $target_archs; do
      if ! [[ "${slice_variant}" == "$target_variant" ]]; then
        matched_all_archs="0"
        break
      fi

      if ! echo "${slice_archs}" | tr " " "\n" | grep -F -q -x "$target_arch"; then
        matched_all_archs="0"
        break
      fi
    done

    if [[ "$matched_all_archs" == "1" ]]; then
      # Found a matching slice
      echo "Selected xcframework slice ${paths[$i]}"
      SELECT_SLICE_RETVAL=${paths[$i]}
      break
    fi
  done
}

install_xcframework() {
  local basepath="$1"
  local name="$2"
  local package_type="$3"
  local paths=("${@:4}")

  # Locate the correct slice of the .xcframework for the current architectures
  select_slice "${basepath}" "${paths[@]}"
  local target_path="$SELECT_SLICE_RETVAL"
  if [[ -z "$target_path" ]]; then
    echo "warning: [CP] $(basename ${basepath}): Unable to find matching slice in '${paths[@]}' for the current build architectures ($ARCHS) and platform (${EFFECTIVE_PLATFORM_NAME-${PLATFORM_NAME}})."
    return
  fi
  local source="$basepath/$target_path"

  local destination="${PODS_XCFRAMEWORKS_BUILD_DIR}/${name}"

  if [ ! -d "$destination" ]; then
    mkdir -p "$destination"
  fi

  copy_dir "$source/" "$destination"
  echo "Copied $source to $destination"
}

install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/Base64.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/BVLinearGradient.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/CodePush.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/CoreModules.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/cxxreact.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/DisprzSdk.xcframework" "disprzSdk" "framework" "ios-x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/DoubleConversion.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/FBReactNativeSpec.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/folly.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/glog.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/jsi.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/jsinspector.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/jsireact.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/JWT.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/libwebp.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/Pods_DisprzSdk.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTAnimation.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTBlob.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTImage.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTLinking.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTNetwork.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTSettings.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTText.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTTypeSafety.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTVibration.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RCTYouTube.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/React.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/ReactCommon.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/ReactNativeART.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_camera.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_config.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_device_brightness.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_document_picker.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_geolocation.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_image_picker.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_keep_awake.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_maps.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_music_control.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_netinfo.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_orientation.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_photo_view.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_safe_area_context.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_secure_window.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_slider.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_splash_screen.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_video.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_voice.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/react_native_webview.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNAudio.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNCAsyncStorage.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNCMaskedView.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNDeviceInfo.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNFastImage.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNFS.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNGestureHandler.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNI18n.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNInAppBrowser.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNReanimated.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNScreens.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNSnackbar.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNSound.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNSVG.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/RNVectorIcons.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/rn_fetch_blob.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/SDWebImage.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/SDWebImageWebPCoder.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/SSZipArchive.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/toolbar_android.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/yoga.xcframework" "disprzSdk" "framework" "ios-arm64_x86_64-simulator" "ios-arm64"
install_xcframework "${PODS_ROOT}/../../disprzSdk/Assets/Frameworks/YoutubePlayer_in_WKWebView.xcframework" "disprzSdk" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"

