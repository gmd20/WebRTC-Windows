include_directories("../interface"
					"${webrtc_root}/third_party/opus-1.1/include"
					"${webrtc_root}/webrtc"
					"${webrtc_root}/webrtc/common_audio/signal_processing/include")

set (webrtc_opus_source
        "interface/opus_interface.h"
        "opus_interface.c")

add_library(webrtc_opus STATIC ${webrtc_opus_source})
add_subdirectory("${webrtc_root}/third_party/opus-1.1" "opus")
target_link_libraries(webrtc_opus opus)
