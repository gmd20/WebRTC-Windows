include_directories("../interface"
                	"${webrtc_root}"
					"${webrtc_root}/common_audio/signal_processing/include")

set (webrtc_opus_source
        "interface/opus_interface.h"
        "opus_interface.c")

add_library(webrtc_opus STATIC ${iSACFix_source})
target_link_libraries(webrtc_opus opus)
