cmake_minimum_required(VERSION 2.8)

include_directories("${webrtc_root}/third_party"
					"${webrtc_root}/third_party/testing"
					"${webrtc_root}/third_party/testing/gmock/include"
					"${webrtc_root}/third_party/testing/gtest/include")
if (MSVC)
	include_directories("${webrtc_root}/third_party/gflags/src/windows")
else()
	include_directories("${webrtc_root}/third_party/gflags/src")
endif()


set (channel_transport_source
	"channel_transport/channel_transport.cc"
	"channel_transport/include/channel_transport.h"
	"channel_transport/traffic_control_win.cc"
	"channel_transport/traffic_control_win.h"
	"channel_transport/udp_socket_manager_posix.cc"
	"channel_transport/udp_socket_manager_posix.h"
	"channel_transport/udp_socket_manager_wrapper.cc"
	"channel_transport/udp_socket_manager_wrapper.h"
	"channel_transport/udp_socket_posix.cc"
	"channel_transport/udp_socket_posix.h"
	"channel_transport/udp_socket_wrapper.cc"
	"channel_transport/udp_socket_wrapper.h"
	"channel_transport/udp_socket2_manager_win.cc"
	"channel_transport/udp_socket2_manager_win.h"
	"channel_transport/udp_socket2_win.cc"
	"channel_transport/udp_socket2_win.h"
	"channel_transport/udp_transport.h"
	"channel_transport/udp_transport_impl.cc"
	"channel_transport/udp_transport_impl.h")
extract_platform_specific_source(channel_transport_source)
add_library(channel_transport STATIC ${channel_transport_source})
target_link_libraries(channel_transport gtest)
target_link_libraries(channel_transport system_wrappers)
if (MSVC)
	target_link_libraries(channel_transport Ws2_32.lib)
	target_compile_definitions(channel_transport PRIVATE "_WINSOCKAPI_")
endif()


add_library(frame_generator STATIC
			"frame_generator.cc"
			"frame_generator.h")
target_link_libraries(frame_generator common_video)


add_library(metrics STATIC
			"testsupport/metrics/video_metrics.h"
			"testsupport/metrics/video_metrics.cc")
target_link_libraries(metrics common_video)
target_link_libraries(metrics system_wrappers)


set (test_support_source
	"test_suite.cc"
	"test_suite.h"
	# "testsupport/android/root_path_android.cc"
	# "testsupport/android/root_path_android_chromium.cc"
	"testsupport/fileutils.cc"
	"testsupport/fileutils.h"
	"testsupport/frame_reader.cc"
	"testsupport/frame_reader.h"
	"testsupport/frame_writer.cc"
	"testsupport/frame_writer.h"
	"testsupport/gtest_prod_util.h"
	"testsupport/gtest_disable.h"
	"testsupport/mock/mock_frame_reader.h"
	"testsupport/mock/mock_frame_writer.h"
	"testsupport/packet_reader.cc"
	"testsupport/packet_reader.h"
	"testsupport/perf_test.cc"
	"testsupport/perf_test.h"
	"testsupport/trace_to_stderr.cc"
	"testsupport/trace_to_stderr.h")
add_library(test_support STATIC ${test_support_source})
target_link_libraries(test_support gtest)
target_link_libraries(test_support gmock)
target_link_libraries(test_support gflags)
target_link_libraries(test_support system_wrappers)
# These macros exist so flags and symbols are properly
# exported when building DLLs. Since we don't build DLLs, we
# need to disable them.
target_compile_definitions(test_support
	PRIVATE "GFLAGS_DLL_DECL="
	PRIVATE "GFLAGS_DLL_DECLARE_FLAG="
	PRIVATE "GFLAGS_DLL_DEFINE_FLAG=")
# 为所有依赖这个库的项目添加包含头文件
target_include_directories(test_support
	PUBLIC "${webrtc_root}/third_party"
	PUBLIC "${webrtc_root}/third_party/testing"
	PUBLIC "${webrtc_root}/third_party/testing/gmock/include"
	PUBLIC "${webrtc_root}/third_party/testing/gtest/include")


add_library(test_support_main STATIC "run_all_unittests.cc")
target_link_libraries(test_support_main test_support)


set (test_support_unittests_source
	"channel_transport/udp_transport_unittest.cc"
	"channel_transport/udp_socket_manager_unittest.cc"
	"channel_transport/udp_socket_wrapper_unittest.cc"
	"testsupport/unittest_utils.h"
	"testsupport/fileutils_unittest.cc"
	"testsupport/frame_reader_unittest.cc"
	"testsupport/frame_writer_unittest.cc"
	"testsupport/packet_reader_unittest.cc"
	"testsupport/perf_test_unittest.cc")
add_executable(test_support_unittests ${test_support_unittests_source})
target_link_libraries(test_support_unittests gtest)
target_link_libraries(test_support_unittests gmock)
target_link_libraries(test_support_unittests channel_transport)
target_link_libraries(test_support_unittests test_support_main)
if (MSVC)
	target_compile_options(test_support_unittests PRIVATE "/wd4267")
endif()
