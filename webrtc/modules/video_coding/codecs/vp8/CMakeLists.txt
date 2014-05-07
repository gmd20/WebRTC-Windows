include_directories("${webrtc_root}/")

set (webrtc_vp8_source
	"reference_picture_selection.h"
	"reference_picture_selection.cc"
	"include/vp8.h"
	"include/vp8_common_types.h"
	"vp8_impl.cc"
	"default_temporal_layers.cc"
	"default_temporal_layers.h"
	"realtime_temporal_layers.cc"
	"temporal_layers.h")

add_library(webrtc_vp8 STATIC ${webrtc_vp8_source})
target_link_libraries(webrtc_vp8 common_video)
target_link_libraries(webrtc_vp8 video_coding_utility)
target_link_libraries(webrtc_vp8 system_wrappers)
if (${build_libvpx})
	include ("${webrtc_root}/third_party/libvpx/CMakeLists.txt")
	target_link_libraries(webrtc_vp8 libvpx)
	target_include_directories(webrtc_vp8 PRIVATE ${libvpx_include_dir})
endif()
if (MSVC)
	target_compile_options(webrtc_vp8 PRIVATE "/wd4267")
endif()

if (${include_tests})
	set (vp8_coder_source "vp8_sequence_coder.cc")

	add_executable(vp8_coder  ${vp8_coder_source})
	target_link_libraries(vp8_coder webrtc_vp8)
	target_link_libraries(vp8_coder common_video)
	target_link_libraries(vp8_coder metrics)
	target_link_libraries(vp8_coder gtest)
	target_link_libraries(vp8_coder system_wrappers)
	target_link_libraries(vp8_coder test_support_main)
	target_link_libraries(vp8_coder command_line_parser)
endif()


