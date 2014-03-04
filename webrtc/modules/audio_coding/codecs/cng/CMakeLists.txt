include_directories("include"
                	"${webrtc_root}"
                	"${webrtc_root}/common_audio/signal_processing/include")

set (CNG_source
        "include/webrtc_cng.h"
		"webrtc_cng.c"
        "cng_helpfuns.c"
        "cng_helpfuns.h")

add_library(CNG STATIC ${CNG_source})
add_dependencies(CNG common_audio)
