include_directories("${webrtc_root}/")

set (webrtc_i420_source
	"../interface/i420.h"
	"i420.cc")

add_library(webrtc_i420 STATIC ${webrtc_i420_source})
target_link_libraries(webrtc_i420 system_wrappers)
