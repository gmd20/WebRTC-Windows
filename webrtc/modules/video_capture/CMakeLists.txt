include_directories("${webrtc_root}/")

set (video_capture_module_source
        "device_info_impl.cc"
        "device_info_impl.h"
        "include/video_capture.h"
        "include/video_capture_defines.h"
        "include/video_capture_factory.h"
        "video_capture_config.h"
        "video_capture_delay.h"
        "video_capture_factory.cc"
        "video_capture_impl.cc"
        "video_capture_impl.h")

if (${include_internal_video_capture} EQUAL 0)
	list(APPEND video_capture_module_source
		"external/device_info_external.cc"
		"external/video_capture_external.cc")
else()
	if(MSVC)
		list(APPEND video_capture_module_source
                "windows/device_info_ds.cc"
                "windows/device_info_ds.h"
                "windows/device_info_mf.cc"
                "windows/device_info_mf.h"
                "windows/help_functions_ds.cc"
                "windows/help_functions_ds.h"
                "windows/sink_filter_ds.cc"
                "windows/sink_filter_ds.h"
                "windows/video_capture_ds.cc"
                "windows/video_capture_ds.h"
                "windows/video_capture_factory_windows.cc"
                "windows/video_capture_mf.cc"
                "windows/video_capture_mf.h")
	elseif (UNIX)
		list(APPEND video_capture_module_source
			"linux/device_info_linux.cc"
			"linux/device_info_linux.h"
			"linux/video_capture_linux.cc"
			"linux/video_capture_linux.h")
	else()
		message(FATAL_ERROR "this platform is not defined. check gyp file and add it here.")
	endif()
endif()

add_library(video_capture_module STATIC ${video_capture_module_source})
target_link_libraries(video_capture_module webrtc_utility)
target_link_libraries(video_capture_module common_video)
target_link_libraries(video_capture_module system_wrappers)
if (MSVC)
	if (${include_internal_video_capture} EQUAL 1)
		add_subdirectory(${webrtc_root}/third_party/winsdk_samples winsdk_samples)
		target_link_libraries(video_capture_module directshow_baseclasses)
		target_link_libraries(video_capture_module Strmiids)
	endif()
endif()

if (${include_tests})
	set (video_capture_tests_source
			"test/video_capture_unittest.cc"
			"test/video_capture_main_mac.mm")
	add_executable(video_capture_tests ${video_capture_tests_source})
	target_link_libraries(video_capture_tests video_capture_module)
	target_link_libraries(video_capture_tests webrtc_utility)
	target_link_libraries(video_capture_tests system_wrappers)
	target_link_libraries(video_capture_tests gtest)
	target_link_libraries(video_capture_tests test_support_main)
	if (UNIX)
		target_compile_options(video_capture_tests PRIVATE -Wno-write-strings)
		target_link_libraries(video_capture_tests pthread m rt Xert X11)
	endif()
endif()

