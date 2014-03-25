include_directories("${webrtc_root}/")

set (rtp_rtcp_source
        # Common
        "../interface/fec_receiver.h"
        "../interface/receive_statistics.h"
        "../interface/rtp_header_parser.h"
        "../interface/rtp_payload_registry.h"
        "../interface/rtp_receiver.h"
        "../interface/rtp_rtcp.h"
        "../interface/rtp_rtcp_defines.h"
        "bitrate.cc"
        "bitrate.h"
        "byte_io.h"
        "fec_receiver_impl.cc"
        "fec_receiver_impl.h"
        "receive_statistics_impl.cc"
        "receive_statistics_impl.h"
        "rtp_header_parser.cc"
        "rtp_rtcp_config.h"
        "rtp_rtcp_impl.cc"
        "rtp_rtcp_impl.h"
        "rtcp_receiver.cc"
        "rtcp_receiver.h"
        "rtcp_receiver_help.cc"
        "rtcp_receiver_help.h"
        "rtcp_sender.cc"
        "rtcp_sender.h"
        "rtcp_utility.cc"
        "rtcp_utility.h"
        "rtp_header_extension.cc"
        "rtp_header_extension.h"
        "rtp_receiver_impl.cc"
        "rtp_receiver_impl.h"
        "rtp_sender.cc"
        "rtp_sender.h"
        "rtp_utility.cc"
        "rtp_utility.h"
        "ssrc_database.cc"
        "ssrc_database.h"
        "tmmbr_help.cc"
        "tmmbr_help.h"
        # Audio Files
        "dtmf_queue.cc"
        "dtmf_queue.h"
        "rtp_receiver_audio.cc"
        "rtp_receiver_audio.h"
        "rtp_sender_audio.cc"
        "rtp_sender_audio.h"
        # Video Files
        "fec_private_tables_random.h"
        "fec_private_tables_bursty.h"
        "forward_error_correction.cc"
        "forward_error_correction.h"
        "forward_error_correction_internal.cc"
        "forward_error_correction_internal.h"
        "producer_fec.cc"
        "producer_fec.h"
        "rtp_packet_history.cc"
        "rtp_packet_history.h"
        "rtp_payload_registry.cc"
        "rtp_receiver_strategy.cc"
        "rtp_receiver_strategy.h"
        "rtp_receiver_video.cc"
        "rtp_receiver_video.h"
        "rtp_sender_video.cc"
        "rtp_sender_video.h"
        "video_codec_information.h"
        "rtp_format_vp8.cc"
        "rtp_format_vp8.h"
        "rtp_format_video_generic.h"
        "vp8_partition_aggregator.cc"
        "vp8_partition_aggregator.h"
        # Mocks
        "../mocks/mock_rtp_rtcp.h"
        "mock/mock_rtp_payload_strategy.h")
add_library(rtp_rtcp STATIC ${rtp_rtcp_source})
target_link_libraries(rtp_rtcp system_wrappers)
target_link_libraries(rtp_rtcp paced_sender)
target_link_libraries(rtp_rtcp remote_bitrate_estimator)
if (MSVC)
	target_compile_options(rtp_rtcp PRIVATE "/wd4267")
endif()


