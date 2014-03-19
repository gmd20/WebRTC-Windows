include_directories("${webrtc_root}/webrtc")



PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS "unittest.proto")
add_library(audioproc_unittest_proto STATIC ${PROTO_SRCS} ${PROTO_HDRS})
# PROTOBUF_GENERATE_CPP默认生成的文件放在build目录下，
# 复制出来便于其他项目文件引用
add_custom_command(TARGET audioproc_unittest_proto POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E copy ${PROTO_HDRS} "${CMAKE_CURRENT_SOURCE_DIR}/unittest.pb.h")
target_link_libraries(audioproc_unittest_proto ${PROTOBUF_LIBRARIES})
target_include_directories(audioproc_unittest_proto
	PUBLIC "${PROTOBUF_INCLUDE_DIRS}")



set (audioproc_source
        "process_test.cc")
add_executable(audioproc ${audioproc_source})
target_link_libraries(audioproc audio_processing)
target_link_libraries(audioproc audioproc_debug_proto)
target_link_libraries(audioproc gtest)
target_link_libraries(audioproc test_support)
target_link_libraries(audioproc system_wrappers)
target_include_directories(audioproc
	PRIVATE "${webrtc_root}/third_party"
	PRIVATE "${webrtc_root}/third_party/testing/gtest/include")



set (unpack_aecdump_source
        "unpack.cc")
add_executable(unpack_aecdump ${unpack_aecdump_source})
target_link_libraries(unpack_aecdump audioproc_debug_proto)
target_link_libraries(unpack_aecdump gflags)
target_link_libraries(unpack_aecdump system_wrappers)
if(MSVC)
	target_include_directories(unpack_aecdump PRIVATE "${webrtc_root}/third_party/gflags/src/windows")
	target_include_directories(unpack_aecdump PRIVATE "${webrtc_root}/third_party/gflags/src")
else()
	target_include_directories(unpack_aecdump PRIVATE "${webrtc_root}/third_party/gflags/src")
endif()
