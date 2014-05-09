include_directories("${webrtc_root}/")

set (webrtc_test_common_source
	"configurable_frame_size_encoder.cc"
	"configurable_frame_size_encoder.h"
	"direct_transport.cc"
	"direct_transport.h"
	"fake_audio_device.cc"
	"fake_audio_device.h"
	"fake_decoder.cc"
	"fake_decoder.h"
	"fake_encoder.cc"
	"fake_encoder.h"
	"fake_network_pipe.cc"
	"fake_network_pipe.h"
	"flags.cc"
	"flags.h"
	"frame_generator_capturer.cc"
	"frame_generator_capturer.h"
	"gl/gl_renderer.cc"
	"gl/gl_renderer.h"
	"linux/glx_renderer.cc"
	"linux/glx_renderer.h"
	"linux/video_renderer_linux.cc"
	"mac/run_tests.mm"
	"mac/video_renderer_mac.h"
	"mac/video_renderer_mac.mm"
	"mock_transport.h"
	"null_platform_renderer.cc"
	"null_transport.cc"
	"null_transport.h"
	"rtp_rtcp_observer.h"
	"run_tests.cc"
	"run_tests.h"
	"run_loop.cc"
	"run_loop.h"
	"statistics.cc"
	"statistics.h"
	"vcm_capturer.cc"
	"vcm_capturer.h"
	"video_capturer.cc"
	"video_capturer.h"
	"video_renderer.cc"
	"video_renderer.h"
	"win/d3d_renderer.cc"
	"win/d3d_renderer.h"
	"win/run_loop_win.cc")
if (${OS} STREQUAL "linux")
	list(REMOVE_ITEM webrtc_test_common_source
		"null_platform_renderer.cc")
endif()
if (${OS} STREQUAL "mac")
	list(REMOVE_ITEM webrtc_test_common_source
		"null_platform_renderer.cc"
		"run_tests.cc")
endif()
if ((NOT ${OS} STREQUAL "linux") AND (NOT ${OS} STREQUAL "mac"))
	list(REMOVE_ITEM webrtc_test_common_source
		"gl/gl_renderer.cc"
		"gl/gl_renderer.h")
endif()
if (${OS} STREQUAL "win")
	list(REMOVE_ITEM webrtc_test_common_source
		"null_platform_renderer.cc"
		"run_loop.cc")
endif()

extract_platform_specific_source(webrtc_test_common_source)
add_library(webrtc_test_common STATIC ${webrtc_test_common_source})
if (${OS} STREQUAL "linux")
	target_link_libraries(webrtc_test_common Xext X11 GL)
endif()
target_link_libraries(webrtc_test_common gtest gflags video_capture_module media_file frame_generator test_support)


if(${include_tests})
	set (webrtc_test_common_unittests_source
		"fake_network_pipe_unittest.cc")
	add_executable(webrtc_test_common_unittests ${webrtc_test_common_unittests_source})
	target_link_libraries(webrtc_test_common_unittests webrtc_test_common)
	target_link_libraries(webrtc_test_common_unittests gtest)
	target_link_libraries(webrtc_test_common_unittests gmock)
	target_link_libraries(webrtc_test_common_unittests test_support_main)
endif()
