include_directories("${webrtc_root}/")

set (video_coding_utility_source
	"include/exp_filter.h"
	"include/frame_dropper.h"
	"exp_filter.cc"
	"frame_dropper.cc")

add_library(video_coding_utility STATIC ${video_coding_utility_source})
target_link_libraries(video_coding_utility system_wrappers)
