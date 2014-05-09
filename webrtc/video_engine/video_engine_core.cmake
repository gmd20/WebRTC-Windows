include_directories("${webrtc_root}/")

set (video_engine_core_source
	# interface
	"include/vie_base.h"
	"include/vie_capture.h"
	"include/vie_codec.h"
	"include/vie_encryption.h"
	"include/vie_errors.h"
	"include/vie_external_codec.h"
	"include/vie_image_process.h"
	"include/vie_network.h"
	"include/vie_render.h"
	"include/vie_rtp_rtcp.h"

	# headers
	"call_stats.h"
	"encoder_state_feedback.h"
	"overuse_frame_detector.h"
	"stream_synchronization.h"
	"vie_base_impl.h"
	"vie_capture_impl.h"
	"vie_codec_impl.h"
	"vie_defines.h"
	"vie_encryption_impl.h"
	"vie_external_codec_impl.h"
	"vie_image_process_impl.h"
	"vie_impl.h"
	"vie_network_impl.h"
	"vie_ref_count.h"
	"vie_remb.h"
	"vie_render_impl.h"
	"vie_rtp_rtcp_impl.h"
	"vie_shared_data.h"
	"vie_capturer.h"
	"vie_channel.h"
	"vie_channel_group.h"
	"vie_channel_manager.h"
	"vie_encoder.h"
	"vie_file_image.h"
	"vie_frame_provider_base.h"
	"vie_input_manager.h"
	"vie_manager_base.h"
	"vie_receiver.h"
	"vie_renderer.h"
	"vie_render_manager.h"
	"vie_sender.h"
	"vie_sync_module.h"

	# ViE
	"call_stats.cc"
	"encoder_state_feedback.cc"
	"overuse_frame_detector.cc"
	"stream_synchronization.cc"
	"vie_base_impl.cc"
	"vie_capture_impl.cc"
	"vie_codec_impl.cc"
	"vie_encryption_impl.cc"
	"vie_external_codec_impl.cc"
	"vie_image_process_impl.cc"
	"vie_impl.cc"
	"vie_network_impl.cc"
	"vie_ref_count.cc"
	"vie_render_impl.cc"
	"vie_rtp_rtcp_impl.cc"
	"vie_shared_data.cc"
	"vie_capturer.cc"
	"vie_channel.cc"
	"vie_channel_group.cc"
	"vie_channel_manager.cc"
	"vie_encoder.cc"
	"vie_file_image.cc"
	"vie_frame_provider_base.cc"
	"vie_input_manager.cc"
	"vie_manager_base.cc"
	"vie_receiver.cc"
	"vie_remb.cc"
	"vie_renderer.cc"
	"vie_render_manager.cc"
	"vie_sender.cc"
	"vie_sync_module.cc")


add_library(video_engine_core STATIC ${video_engine_core_source})
target_link_libraries(video_engine_core common_audio
										rtp_rtcp
										webrtc_utility
										bitrate_controller
										video_capture_module
										webrtc_video_coding
										video_processing
										video_render_module
										voice_engine
										system_wrappers)
if (MSVC)
	target_compile_options(video_engine_core PRIVATE "/wd4267")
endif()


if (${include_tests})
	set (video_engine_core_unittests_source
            "call_stats_unittest.cc"
            "encoder_state_feedback_unittest.cc"
            "overuse_frame_detector_unittest.cc"
            "stream_synchronization_unittest.cc"
            "vie_remb_unittest.cc")
	add_executable(video_engine_core_unittests ${video_engine_core_unittests_source})
	target_link_libraries(video_engine_core_unittests video_engine_core gtest gmock test_support_main)
endif()

