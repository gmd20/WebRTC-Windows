include_directories("${webrtc_root}/")

set (video_render_module_source
	"android/video_render_android_impl.cc"
	"android/video_render_android_impl.h"
	"android/video_render_android_native_opengl2.cc"
	"android/video_render_android_native_opengl2.h"
	"android/video_render_android_surface_view.cc"
	"android/video_render_android_surface_view.h"
	"android/video_render_opengles20.cc"
	"android/video_render_opengles20.h"
	"external/video_render_external_impl.cc"
	"external/video_render_external_impl.h"
	"i_video_render.h"
	"include/video_render.h"
	"include/video_render_defines.h"
	"incoming_video_stream.cc"
	"incoming_video_stream.h"
	"ios/open_gles20.h"
	"ios/open_gles20.mm"
	"ios/video_render_ios_channel.h"
	"ios/video_render_ios_channel.mm"
	"ios/video_render_ios_gles20.h"
	"ios/video_render_ios_gles20.mm"
	"ios/video_render_ios_impl.h"
	"ios/video_render_ios_impl.mm"
	"ios/video_render_ios_view.h"
	"ios/video_render_ios_view.mm"
	"linux/video_render_linux_impl.cc"
	"linux/video_render_linux_impl.h"
	"linux/video_x11_channel.cc"
	"linux/video_x11_channel.h"
	"linux/video_x11_render.cc"
	"linux/video_x11_render.h"
	"mac/cocoa_full_screen_window.mm"
	"mac/cocoa_full_screen_window.h"
	"mac/cocoa_render_view.mm"
	"mac/cocoa_render_view.h"
	"mac/video_render_agl.cc"
	"mac/video_render_agl.h"
	"mac/video_render_mac_carbon_impl.cc"
	"mac/video_render_mac_carbon_impl.h"
	"mac/video_render_mac_cocoa_impl.h"
	"mac/video_render_mac_cocoa_impl.mm"
	"mac/video_render_nsopengl.h"
	"mac/video_render_nsopengl.mm"
	"video_render_frames.cc"
	"video_render_frames.h"
	"video_render_impl.cc"
	"video_render_impl.h"
	"windows/i_video_render_win.h"
	"windows/video_render_direct3d9.cc"
	"windows/video_render_direct3d9.h"
	"windows/video_render_windows_impl.cc"
	"windows/video_render_windows_impl.h")

if (${include_internal_video_capture} EQUAL 1)
	add_definitions("/DWEBRTC_INCLUDE_INTERNAL_VIDEO_RENDER")
endif()

if((NOT ${OS} STREQUAL "android") OR (${include_internal_video_capture} EQUAL 0))
	list(REMOVE_ITEM  video_render_module_source
		"android/video_render_android_impl.h"
		"android/video_render_android_native_opengl2.h"
		"android/video_render_android_surface_view.h"
		"android/video_render_opengles20.h"
		"android/video_render_android_impl.cc"
		"android/video_render_android_native_opengl2.cc"
		"android/video_render_android_surface_view.cc"
		"android/video_render_opengles20.cc")
endif()

if((NOT ${OS} STREQUAL "ios") OR (${include_internal_video_capture} EQUAL 0))
	list(REMOVE_ITEM  video_render_module_source
		"ios/open_gles20.h"
		"ios/open_gles20.mm"
		"ios/video_render_ios_channel.h"
		"ios/video_render_ios_channel.mm"
		"ios/video_render_ios_gles20.h"
		"ios/video_render_ios_gles20.mm"
		"ios/video_render_ios_impl.h"
		"ios/video_render_ios_impl.mm"
		"ios/video_render_ios_view.h"
		"ios/video_render_ios_view.mm")
endif()

if((NOT ${OS} STREQUAL "linux") OR (${include_internal_video_capture} EQUAL 0))
	list(REMOVE_ITEM  video_render_module_source
		"linux/video_render_linux_impl.h"
		"linux/video_x11_channel.h"
		"linux/video_x11_render.h"
		"linux/video_render_linux_impl.cc"
		"linux/video_x11_channel.cc"
		"linux/video_x11_render.cc")
endif()

if((NOT ${OS} STREQUAL "mac") OR (${include_internal_video_capture} EQUAL 0))
	list(REMOVE_ITEM  video_render_module_source
		"mac/cocoa_full_screen_window.h"
		"mac/cocoa_render_view.h"
		"mac/video_render_agl.h"
		"mac/video_render_mac_carbon_impl.h"
		"mac/video_render_mac_cocoa_impl.h"
		"mac/video_render_nsopengl.h"
		"mac/video_render_nsopengl.mm"
		"mac/video_render_mac_cocoa_impl.mm"
		"mac/video_render_agl.cc"
		"mac/video_render_mac_carbon_impl.cc"
		"mac/cocoa_render_view.mm"
		"mac/cocoa_full_screen_window.mm")
endif()

if((NOT ${OS} STREQUAL "win") OR (${include_internal_video_capture} EQUAL 0))
	list(REMOVE_ITEM  video_render_module_source
		"windows/i_video_render_win.h"
		"windows/video_render_direct3d9.h"
		"windows/video_render_windows_impl.h"
		"windows/video_render_direct3d9.cc"
		"windows/video_render_windows_impl.cc")
endif()


add_library(video_render_module STATIC ${video_render_module_source})
target_link_libraries(video_render_module webrtc_utility)
target_link_libraries(video_render_module common_video)
target_link_libraries(video_render_module system_wrappers)

if (${OS} STREQUAL "ios")
	target_link_options(video_render_module "-framework OpenGLES -framework QuartzCore -framework UIKit")
endif()

if (${OS} STREQUAL "win" AND ${include_internal_video_render} EQUAL 1)
	if (NOT ${MSVC12})
		# 新版的visual studio 已经自带 directsdk了，不用这个这个包含目录的了
		set (directx_sdk_path "${webrtc_root}/third_party/directxsdk/files")
		if ( NOT EXISTS ${directx_sdk_path})
			message(FATAL_ERROR "The directx_sdk_path(${directx_sdk_path}) doesn't exist.")
		endif()
		target_include_directories(video_render_module PRIVATE "${directx_sdk_path}/Include")
	endif()
endif()

if (${include_tests})
	set (video_render_tests_source
		"test/testAPI/testAPI.cc"
		"test/testAPI/testAPI.h")
	if (${OS} STREQUAL "android")
		list(append video_render_tests_source "test/testAPI/testAPI_android.cc")
	endif()
	if (${OS} STREQUAL "mac")
		list(append video_render_tests_source "test/testAPI/testAPI_mac.mm")
	endif()
	add_executable(video_render_tests ${video_render_tests_source})
	target_link_libraries(video_render_tests video_render_module)
	target_link_libraries(video_render_tests webrtc_utility)
	target_link_libraries(video_render_tests system_wrappers)
	if (${OS} STREQUAL "linux")
		target_compile_options(video_render_tests PRIVATE "-Wno-write-strings")
		target_link_libraries(video_render_tests pthread m rt Xert X11)
	endif()
endif()

