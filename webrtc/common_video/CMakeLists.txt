include_directories("../modules/interface/"
					"interface"
					"libyuv/include")


set (common_video_source
        "interface/i420_video_frame.h"
        "interface/native_handle.h"
        "interface/texture_video_frame.h"
        "i420_video_frame.cc"
        "libyuv/include/webrtc_libyuv.h"
        "libyuv/include/scaler.h"
        "libyuv/webrtc_libyuv.cc"
        "libyuv/scaler.cc"
        "plane.h"
        "plane.cc"
        "texture_video_frame.cc")



add_library(common_video STATIC ${common_video_source})
add_dependencies(common_video system_wrappers)

if (${build_libyuv})
	add_subdirectory("${libyuv_dir}" "libyuv")
	target_include_directories(common_video PRIVATE "${libyuv_dir}/include")
	target_link_libraries(common_video libyuv)
endif()
