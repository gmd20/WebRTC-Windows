include_directories("${webrtc_root}/")

set (video_loopback_source
	"video/loopback.cc"
	"test/test_main.cc")
add_executable(video_loopback ${video_loopback_source})
target_link_libraries(video_loopback gtest webrtc_test_common webrtc)


set (video_engine_tests_source
	"video/bitrate_estimator_tests.cc"
	"video/call_tests.cc"
	"video/send_statistics_proxy_unittest.cc"
	"video/video_send_stream_tests.cc"
	"test/common_unittest.cc"
	"test/testsupport/metrics/video_metrics_unittest.cc"
	"test/test_main.cc")
add_executable(video_engine_tests  ${video_engine_tests_source})
target_link_libraries(video_engine_tests gtest gflags rtp_rtcp metrics webrtc_test_common webrtc)


set (webrtc_perf_tests_source
	"modules/audio_coding/neteq4/test/neteq_performance_unittest.cc"
	"test/test_main.cc"
	"video/call_perf_tests.cc"
	"video/full_stack.cc"
	"video/rampup_tests.cc")
add_executable(webrtc_perf_tests ${webrtc_perf_tests_source})
target_link_libraries(webrtc_perf_tests gtest gflags neteq_unittest_tools rtp_rtcp webrtc_test_common webrtc)



add_custom_target(webrtc_tests)
add_dependencies(webrtc_tests video_engine_tests video_loopback  webrtc_perf_tests)


