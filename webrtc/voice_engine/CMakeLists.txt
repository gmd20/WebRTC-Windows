include_directories("${webrtc_root}/")

set (voice_engine_source
	"../common_types.h"
	"../engine_configurations.h"
	"../typedefs.h"
	"include/voe_audio_processing.h"
	"include/voe_base.h"
	"include/voe_call_report.h"
	"include/voe_codec.h"
	"include/voe_dtmf.h"
	"include/voe_encryption.h"
	"include/voe_errors.h"
	"include/voe_external_media.h"
	"include/voe_file.h"
	"include/voe_hardware.h"
	"include/voe_neteq_stats.h"
	"include/voe_network.h"
	"include/voe_rtp_rtcp.h"
	"include/voe_video_sync.h"
	"include/voe_volume_control.h"
	"channel.cc"
	"channel.h"
	"channel_manager.cc"
	"channel_manager.h"
	"dtmf_inband.cc"
	"dtmf_inband.h"
	"dtmf_inband_queue.cc"
	"dtmf_inband_queue.h"
	"level_indicator.cc"
	"level_indicator.h"
	"monitor_module.cc"
	"monitor_module.h"
	"output_mixer.cc"
	"output_mixer.h"
	"output_mixer_internal.cc"
	"output_mixer_internal.h"
	"shared_data.cc"
	"shared_data.h"
	"statistics.cc"
	"statistics.h"
	"transmit_mixer.cc"
	"transmit_mixer.h"
	"utility.cc"
	"utility.h"
	"voe_audio_processing_impl.cc"
	"voe_audio_processing_impl.h"
	"voe_base_impl.cc"
	"voe_base_impl.h"
	"voe_call_report_impl.cc"
	"voe_call_report_impl.h"
	"voe_codec_impl.cc"
	"voe_codec_impl.h"
	"voe_dtmf_impl.cc"
	"voe_dtmf_impl.h"
	"voe_encryption_impl.cc"
	"voe_encryption_impl.h"
	"voe_external_media_impl.cc"
	"voe_external_media_impl.h"
	"voe_file_impl.cc"
	"voe_file_impl.h"
	"voe_hardware_impl.cc"
	"voe_hardware_impl.h"
	"voe_neteq_stats_impl.cc"
	"voe_neteq_stats_impl.h"
	"voe_network_impl.cc"
	"voe_network_impl.h"
	"voe_rtp_rtcp_impl.cc"
	"voe_rtp_rtcp_impl.h"
	"voe_video_sync_impl.cc"
	"voe_video_sync_impl.h"
	"voe_volume_control_impl.cc"
	"voe_volume_control_impl.h"
	"voice_engine_defines.h"
	"voice_engine_impl.cc"
	"voice_engine_impl.h")

if (${OS} STREQUAL "win")
	add_definitions("-DWEBRTC_DRIFT_COMPENSATION_SUPPORTED")
endif()

add_library(voice_engine STATIC ${voice_engine_source})
target_link_libraries(voice_engine common_audio)
target_link_libraries(voice_engine audio_coding_module)
target_link_libraries(voice_engine audio_conference_mixer)
target_link_libraries(voice_engine audio_device)
target_link_libraries(voice_engine audio_processing)
target_link_libraries(voice_engine media_file)
target_link_libraries(voice_engine rtp_rtcp)
target_link_libraries(voice_engine webrtc_utility)
target_link_libraries(voice_engine system_wrappers)




if (${include_tests})
	include_directories("${webrtc_root}/webrtc")
	set (voice_engine_unittests_source
		"channel_unittest.cc"
		"output_mixer_unittest.cc"
		"transmit_mixer_unittest.cc"
		"voe_audio_processing_unittest.cc"
		"voe_base_unittest.cc"
		"voe_codec_unittest.cc"
		"voe_neteq_stats_unittest.cc")
	add_executable(voice_engine_unittests ${voice_engine_unittests_source})
	target_link_libraries(voice_engine_unittests voice_engine)
	target_link_libraries(voice_engine_unittests gtest)
	target_link_libraries(voice_engine_unittests common_audio)
	target_link_libraries(voice_engine_unittests audio_device)
	target_link_libraries(voice_engine_unittests audio_processing)
	target_link_libraries(voice_engine_unittests audio_coding_module)
	target_link_libraries(voice_engine_unittests audio_conference_mixer)
	target_link_libraries(voice_engine_unittests media_file)
	target_link_libraries(voice_engine_unittests rtp_rtcp)
	target_link_libraries(voice_engine_unittests webrtc_utility)
	target_link_libraries(voice_engine_unittests system_wrappers)
	target_link_libraries(voice_engine_unittests test_support_main)



	set (voe_auto_test_source
		"test/auto_test/automated_mode.cc"
		"test/auto_test/extended/agc_config_test.cc"
		"test/auto_test/extended/ec_metrics_test.cc"
		"test/auto_test/fakes/fake_external_transport.cc"
		"test/auto_test/fakes/fake_external_transport.h"
		"test/auto_test/fixtures/after_initialization_fixture.cc"
		"test/auto_test/fixtures/after_initialization_fixture.h"
		"test/auto_test/fixtures/after_streaming_fixture.cc"
		"test/auto_test/fixtures/after_streaming_fixture.h"
		"test/auto_test/fixtures/before_initialization_fixture.cc"
		"test/auto_test/fixtures/before_initialization_fixture.h"
		"test/auto_test/fuzz/rtp_fuzz_test.cc"
		"test/auto_test/standard/audio_processing_test.cc"
		"test/auto_test/standard/call_report_test.cc"
		"test/auto_test/standard/codec_before_streaming_test.cc"
		"test/auto_test/standard/codec_test.cc"
		"test/auto_test/standard/dtmf_test.cc"
		"test/auto_test/standard/encryption_test.cc"
		"test/auto_test/standard/external_media_test.cc"
		"test/auto_test/standard/file_before_streaming_test.cc"
		"test/auto_test/standard/file_test.cc"
		"test/auto_test/standard/hardware_before_initializing_test.cc"
		"test/auto_test/standard/hardware_before_streaming_test.cc"
		"test/auto_test/standard/hardware_test.cc"
		"test/auto_test/standard/manual_hold_test.cc"
		"test/auto_test/standard/mixing_test.cc"
		"test/auto_test/standard/neteq_stats_test.cc"
		"test/auto_test/standard/neteq_test.cc"
		"test/auto_test/standard/network_test.cc"
		"test/auto_test/standard/rtp_rtcp_before_streaming_test.cc"
		"test/auto_test/standard/rtp_rtcp_test.cc"
		"test/auto_test/standard/voe_base_misc_test.cc"
		"test/auto_test/standard/video_sync_test.cc"
		"test/auto_test/standard/volume_test.cc"
		"test/auto_test/resource_manager.cc"
		"test/auto_test/voe_cpu_test.cc"
		"test/auto_test/voe_cpu_test.h"
		"test/auto_test/voe_extended_test.cc"
		"test/auto_test/voe_extended_test.h"
		"test/auto_test/voe_standard_test.cc"
		"test/auto_test/voe_standard_test.h"
		"test/auto_test/voe_stress_test.cc"
		"test/auto_test/voe_stress_test.h"
		"test/auto_test/voe_test_defines.h"
		"test/auto_test/voe_test_interface.h"
		"test/auto_test/voe_unit_test.cc"
		"test/auto_test/voe_unit_test.h")
	if(${OS} STREQUAL "android")
		list(append voe_auto_test_sourcee "test/auto_test/standard/hardware_before_streaming_test.cc")
	endif()
	add_executable(voe_auto_test ${voe_auto_test_source})
	target_link_libraries(voe_auto_test voice_engine)
	target_link_libraries(voe_auto_test gmock)
	target_link_libraries(voe_auto_test gtest)
	target_link_libraries(voe_auto_test gflags)
	target_link_libraries(voe_auto_test system_wrappers)
	target_link_libraries(voe_auto_test libtest)
	target_link_libraries(voe_auto_test channel_transport)
	target_link_libraries(voe_auto_test test_support)
	if(MSVC)
		target_compile_options(voe_auto_test PRIVATE "/wd4267")
	endif()



	add_executable(voe_cmd_test "test/cmd_test/voe_cmd_test.cc")
	target_link_libraries(voe_cmd_test voice_engine)
	target_link_libraries(voe_cmd_test gtest)
	target_link_libraries(voe_cmd_test gflags)
	target_link_libraries(voe_cmd_test system_wrappers)
	target_link_libraries(voe_cmd_test channel_transport)
	target_link_libraries(voe_cmd_test test_support)
endif()

