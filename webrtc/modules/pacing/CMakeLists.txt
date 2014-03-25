include_directories("${webrtc_root}")

set (paced_sender_source
	"include/paced_sender.h"
	"paced_sender.cc")

add_library(paced_sender STATIC ${paced_sender_source})
target_link_libraries(paced_sender system_wrappers)
