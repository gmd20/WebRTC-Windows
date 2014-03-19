include_directories("../interface"
					"../../interface"
					"${webrtc_root}/webrtc")

set (audio_conference_mixer_source
		"../interface/audio_conference_mixer.h"
        "../interface/audio_conference_mixer_defines.h"
        "audio_frame_manipulator.cc"
        "audio_frame_manipulator.h"
        "level_indicator.cc"
        "level_indicator.h"
        "memory_pool.h"
        "memory_pool_posix.h"
        "memory_pool_win.h"
        "audio_conference_mixer_impl.cc"
        "audio_conference_mixer_impl.h"
        "time_scheduler.cc"
        "time_scheduler.h")

add_library(audio_conference_mixer STATIC ${audio_conference_mixer_source})
target_link_libraries(audio_conference_mixer audio_processing)
target_link_libraries(audio_conference_mixer webrtc_utility)
target_link_libraries(audio_conference_mixer system_wrappers)
