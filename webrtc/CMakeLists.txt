cmake_minimum_required(VERSION 2.8)

include(build-windows/common.cmake)

project(webrtc)

set (webrtc_root ${CMAKE_SOURCE_DIR})
message (STATUS "webrtc_root = ${webrtc_root}")
include_directories("${webrtc_root}/..")

add_subdirectory(system_wrappers)
add_subdirectory(common_audio)
add_subdirectory(common_video)
add_subdirectory(modules)
#add_subdirectory(video)
#add_subdirectory(video_engine)
#add_subdirectory(voice_engine)
#add_subdirectory(${webrtc_vp8_dir})
