include_directories("include"
					"${webrtc_root}/webrtc")

set (audio_coding_module_source
        "include/pcm16b.h"
		"pcm16b.c")

add_library(audio_coding_module STATIC ${audio_coding_module_source})
add_dependencies(audio_coding_module common_audio)
