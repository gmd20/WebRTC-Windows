include_directories("include"
                	"${webrtc_root}"
                	"${webrtc_root}/common_audio/signal_processing/include")

set (PCM16B_source
        "include/pcm16b.h"
		"pcm16b.c")

add_library(PCM16B STATIC ${PCM16B_source})
