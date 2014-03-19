include_directories("../interface"
					"../../interface"
					"${webrtc_root}/webrtc")

set (media_file_source
	"../interface/media_file.h"
	"../interface/media_file_defines.h"
	"avi_file.cc"
	"avi_file.h"
	"media_file_impl.cc"
	"media_file_impl.h"
	"media_file_utility.cc"
	"media_file_utility.h")

add_library(media_file STATIC ${media_file_source})
target_link_libraries(media_file system_wrappers)
if (MSVC)
	target_compile_options(media_file PRIVATE "/wd4267")
endif()
