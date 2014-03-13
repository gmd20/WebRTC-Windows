cmake_minimum_required(VERSION 2.8)

include(build-windows/common.cmake)

project(webrtc)

set (webrtc_root ${CMAKE_SOURCE_DIR})
message (STATUS "webrtc_root = ${webrtc_root}")
include_directories("${webrtc_root}/..")


add_subdirectory(system_wrappers)
add_subdirectory(common_audio)
add_subdirectory(common_video)

if (${include_tests})
	add_subdirectory("${webrtc_root}/../third_party/gflags" gflags)
	# gmock include add_subdirectory(gtest) 
	# add_subdirectory("${webrtc_root}/../third_party/gtest" gtest)
	add_subdirectory("${webrtc_root}/../third_party/gmock" gmock)
	add_subdirectory(test)
endif()

add_subdirectory(modules)
#add_subdirectory(video)
#add_subdirectory(video_engine)
#add_subdirectory(voice_engine)
#add_subdirectory(${webrtc_vp8_dir})




# set (webrtc_source
#         "call.h"
#         "config.h"
#         "experiments.h"
#         "frame_callback.h"
#         "transport.h"
#         "video_receive_stream.h"
#         "video_renderer.h"
#         "video_send_stream.h")
# # TODO(pbos): This is intended to contain audio parts as well as soon as
# #             VoiceEngine moves to the same new API format.
# list(APPEND webrtc_source "${webrtc_video_sources}")
# add_library(webtrc STATIC ${webrtc_source})
# target_link_libraries(webrtc ${webrtc_video_dependencies})

# add_custom_target(webrtc_all)
# add_dependencies(webrtc_all common_audio)
# add_dependencies(webrtc_all common_video)
# add_dependencies(webrtc_all modules)
# add_dependencies(webrtc_all system_wrappers)
# add_dependencies(webrtc_all video_engine)
# add_dependencies(webrtc_all voice_engine)
# add_dependencies(webrtc_all vp8)
# add_dependencies(webrtc_all webtrc)
# if (${include_tests})
# 	add_dependencies(webrtc_all common_video_unittests)
# 	add_dependencies(webrtc_all system_wrappers_tests)
# 	add_dependencies(webrtc_all webrtc_test_common_unittests)
# 	add_dependencies(webrtc_all tools)
# 	add_dependencies(webrtc_all webrtc_tests)
# endif()
