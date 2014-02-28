cmake_minimum_required(VERSION 2.8)


include(build-windows/common.cmake)

project(webrtc)


include_directories(../)


add_subdirectory(common_audio)
#add_subdirectory(common_video)
#add_subdirectory(modules)
add_subdirectory(system_wrappers)
#add_subdirectory(video)
#add_subdirectory(video_engine)
#add_subdirectory(voice_engine)
#add_subdirectory(${webrtc_vp8_dir})
