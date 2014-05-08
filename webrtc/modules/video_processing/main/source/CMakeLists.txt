include_directories("${webrtc_root}/")

set (video_processing_source
	  "../interface/video_processing.h"
        "../interface/video_processing_defines.h"
        "brighten.cc"
        "brighten.h"
        "brightness_detection.cc"
        "brightness_detection.h"
        "color_enhancement.cc"
        "color_enhancement.h"
        "color_enhancement_private.h"
        "content_analysis.cc"
        "content_analysis.h"
        "deflickering.cc"
        "deflickering.h"
        "denoising.cc"
        "denoising.h"
        "frame_preprocessor.cc"
        "frame_preprocessor.h"
        "spatial_resampler.cc"
        "spatial_resampler.h"
        "video_decimator.cc"
        "video_decimator.h"
        "video_processing_impl.cc"
        "video_processing_impl.h")


add_library(video_processing STATIC ${video_processing_source})
target_link_libraries(video_processing webrtc_utility)
target_link_libraries(video_processing common_audio)
target_link_libraries(video_processing common_video)
target_link_libraries(video_processing system_wrappers)

if (${target_arch} STREQUAL "ia32" OR ${target_arch} STREQUAL "x64" )
	add_library(video_processing_sse2 STATIC "content_analysis_sse2.cc")
	if(MSVC)
		message (STATUS "enable video_processing_sse2 in Visual Studio!")
		target_compile_options(video_processing_sse2 PRIVATE "/arch:SSE2")
	elseif(${CMAKE_COMPILER_IS_GNUCXX})
		message (STATUS "enable video_processing_sse2 in gcc!")
		target_compile_options(video_processing_sse2 PRIVATE "-msse2")
	endif()
	target_link_libraries(video_processing video_processing_sse2)
endif()

