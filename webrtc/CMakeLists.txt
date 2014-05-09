cmake_minimum_required(VERSION 2.8)

# 通用配置选项，和通用的全局函数
include(build-windows/common.cmake)

project(webrtc)

get_filename_component(webrtc_root ${CMAKE_SOURCE_DIR} DIRECTORY)
message (STATUS "webrtc_root = ${webrtc_root}")
include_directories("${webrtc_root}")
include_directories("${webrtc_root}")


if (MSVC)
	# 所有的lib和exe统一使用static linking
	add_compile_options("/MT")

	#使用Unicode项目
	add_definitions(-D_UNICODE)

	add_definitions(-DWEBRTC_WIN -DNOMINMAX)
	# TODO(andrew): enable all warnings when possible.
	# TODO(phoglund): get rid of 4373 supression when
	# http://code.google.com/p/webrtc/issues/detail?id=261 is solved.
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} /wd4373  /wd4389")
	set(CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO} /wd4373  /wd4389")
elseif (UNIX)
	add_definitions(-DWEBRTC_LINUX)
endif()

if(${enable_video})
	add_definitions(-DWEBRTC_MODULE_UTILITY_VIDEO)
endif()

if (${enable_protobuf})
	set(PROTOBUF_SRC_ROOT_FOLDER "${webrtc_root}/third_party/protobuf-2.5.0")
	#include(FindProtobuf)
	find_package(Protobuf REQUIRED)
	if (!${PROTOBUF_FOUND})
		message (STATUS "找不到protobuf，自己下载源码编译，并修改commoo.cmake文件里面 set\(PROTOBUF_SRC_ROOT_FOLDER 为相应源码目录。")
	endif()
	message (STATUS "PROTOBUF_INCLUDE_DIRS = ${PROTOBUF_INCLUDE_DIRS}")
	message (STATUS "PROTOBUF_LIBRARIES  = ${PROTOBUF_LIBRARIES}")
endif()


add_subdirectory(system_wrappers)
add_subdirectory(common_audio)
add_subdirectory(common_video)

if (${include_tests})
	add_subdirectory("${webrtc_root}/third_party/gflags" gflags)
	# gmock include add_subdirectory(gtest)
	# add_subdirectory("${webrtc_root}/../third_party/testing/gtest" gtest)
	add_subdirectory("${webrtc_root}/third_party/testing/gmock" gmock)
	add_subdirectory(test)
	add_subdirectory(tools)
endif()

add_subdirectory(modules)
add_subdirectory(voice_engine)
add_subdirectory(video_engine)
include(video/webrtc_video.cmake)
#add_subdirectory(${webrtc_vp8_dir})


set (webrtc_source
        "call.h"
        "config.h"
        "experiments.h"
        "frame_callback.h"
        "transport.h"
        "video_receive_stream.h"
        "video_renderer.h"
        "video_send_stream.h")
# TODO(pbos): This is intended to contain audio parts as well as soon as
#             VoiceEngine moves to the same new API format.
list(APPEND webrtc_source "${webrtc_video_sources}")
add_library(webrtc STATIC ${webrtc_source})
target_link_libraries(webrtc ${webrtc_video_dependencies})

add_custom_target(webrtc_all)
add_dependencies(webrtc_all common_audio
							common_video
							modules
							system_wrappers
							video_engine
							voice_engine
							vp8
							webrtc)
if (${include_tests})
	include(webrtc_tests.cmake)
	add_dependencies(webrtc_all common_video_unittests
								system_wrappers_tests
								webrtc_test_common_unittests
								tools
								webrtc_tests)
endif()
