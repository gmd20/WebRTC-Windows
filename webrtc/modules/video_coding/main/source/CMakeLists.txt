include_directories("${webrtc_root}/")

set (webrtc_video_coding_source
        # interfaces
        "../interface/video_coding.h"
        "../interface/video_coding_defines.h"

        # headers
        "codec_database.h"
        "codec_timer.h"
        "content_metrics_processing.h"
        "decoding_state.h"
        "encoded_frame.h"
        "er_tables_xor.h"
        "fec_tables_xor.h"
        "frame_buffer.h"
        "generic_decoder.h"
        "generic_encoder.h"
        "inter_frame_delay.h"
        "internal_defines.h"
        "jitter_buffer.h"
        "jitter_buffer_common.h"
        "jitter_estimator.h"
        "media_opt_util.h"
        "media_optimization.h"
        "nack_fec_tables.h"
        "packet.h"
        "qm_select_data.h"
        "qm_select.h"
        "receiver.h"
        "rtt_filter.h"
        "session_info.h"
        "timestamp_extrapolator.h"
        "timestamp_map.h"
        "timing.h"
        "video_coding_impl.h"

        # sources
        "codec_database.cc"
        "codec_timer.cc"
        "content_metrics_processing.cc"
        "decoding_state.cc"
        "encoded_frame.cc"
        "frame_buffer.cc"
        "generic_decoder.cc"
        "generic_encoder.cc"
        "inter_frame_delay.cc"
        "jitter_buffer.cc"
        "jitter_estimator.cc"
        "media_opt_util.cc"
        "media_optimization.cc"
        "packet.cc"
        "qm_select.cc"
        "receiver.cc"
        "rtt_filter.cc"
        "session_info.cc"
        "timestamp_extrapolator.cc"
        "timestamp_map.cc"
        "timing.cc"
        "video_coding_impl.cc"
        "video_sender.cc"
        "video_receiver.cc")

add_library(webrtc_video_coding STATIC ${webrtc_video_coding_source})
target_link_libraries(webrtc_video_coding webrtc_i420)
target_link_libraries(webrtc_video_coding common_video)
target_link_libraries(webrtc_video_coding video_coding_utility)
target_link_libraries(webrtc_video_coding system_wrappers)
target_link_libraries(webrtc_video_coding webrtc_vp8)
if (MSVC)
	target_compile_options(webrtc_video_coding PRIVATE "/wd4267")
endif()
