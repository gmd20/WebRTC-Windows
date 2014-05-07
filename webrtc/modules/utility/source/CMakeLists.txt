include_directories("../interface"
					"${webrtc_root}/webrtc")

set (webrtc_utility_source
       "../interface/audio_frame_operations.h"
        "../interface/file_player.h"
        "../interface/file_recorder.h"
        "../interface/helpers_android.h"
        "../interface/process_thread.h"
        "../interface/rtp_dump.h"
        "audio_frame_operations.cc"
        "coder.cc"
        "coder.h"
        "file_player_impl.cc"
        "file_player_impl.h"
        "file_recorder_impl.cc"
        "file_recorder_impl.h"
        "helpers_android.cc"
        "process_thread_impl.cc"
        "process_thread_impl.h"
        "rtp_dump_impl.cc"
        "rtp_dump_impl.h")

if (${enable_video})
	list(APPEND awebrtc_utility_source
		"frame_scaler.cc"
		"video_coder.cc"
		"video_frames_queue.cc")
endif()
add_library(webrtc_utility STATIC ${webrtc_utility_source})
target_link_libraries(webrtc_utility audio_coding_module)
target_link_libraries(webrtc_utility media_file)
target_link_libraries(webrtc_utility common_audio)
target_link_libraries(webrtc_utility system_wrappers)
if (${enable_video})
	target_link_libraries(webrtc_utility webrtc_video_coding)
endif()
