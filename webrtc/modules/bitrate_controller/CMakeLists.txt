include_directories("${webrtc_root}/")

set (bitrate_controller_source
	"bitrate_controller_impl.cc"
	"bitrate_controller_impl.h"
	"include/bitrate_controller.h"
	"send_side_bandwidth_estimation.cc"
	"send_side_bandwidth_estimation.h")

add_library(bitrate_controller STATIC ${bitrate_controller_source})
target_link_libraries(bitrate_controller system_wrappers)
if (MSVC)
	target_compile_options(bitrate_controller PRIVATE "/wd4267")
endif()
