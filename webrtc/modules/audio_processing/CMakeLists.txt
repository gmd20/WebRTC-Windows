include_directories("../interface"
					"../../interface"
					"${webrtc_root}/webrtc"
					"${webrtc_root}")

set (audio_processing_source
        "aec/include/echo_cancellation.h"
        "aec/echo_cancellation.c"
        "aec/echo_cancellation_internal.h"
        "aec/aec_core.h"
        "aec/aec_core.c"
        "aec/aec_core_internal.h"
        "aec/aec_rdft.h"
        "aec/aec_rdft.c"
        "aec/aec_resampler.h"
        "aec/aec_resampler.c"
        "aecm/include/echo_control_mobile.h"
        "aecm/echo_control_mobile.c"
        "aecm/aecm_core.c"
        "aecm/aecm_core.h"
        "agc/include/gain_control.h"
        "agc/analog_agc.c"
        "agc/analog_agc.h"
        "agc/digital_agc.c"
        "agc/digital_agc.h"
        "audio_buffer.cc"
        "audio_buffer.h"
        "audio_processing_impl.cc"
        "audio_processing_impl.h"
        "echo_cancellation_impl.cc"
        "echo_cancellation_impl.h"
        "echo_cancellation_impl_wrapper.h"
        "echo_control_mobile_impl.cc"
        "echo_control_mobile_impl.h"
        "gain_control_impl.cc"
        "gain_control_impl.h"
        "high_pass_filter_impl.cc"
        "high_pass_filter_impl.h"
        "include/audio_processing.h"
        "level_estimator_impl.cc"
        "level_estimator_impl.h"
        "noise_suppression_impl.cc"
        "noise_suppression_impl.h"
        "processing_component.cc"
        "processing_component.h"
        "utility/delay_estimator.c"
        "utility/delay_estimator.h"
        "utility/delay_estimator_internal.h"
        "utility/delay_estimator_wrapper.c"
        "utility/delay_estimator_wrapper.h"
        "utility/fft4g.c"
        "utility/fft4g.h"
        "utility/ring_buffer.c"
        "utility/ring_buffer.h"
        "voice_detection_impl.cc"
        "voice_detection_impl.h")

if (${prefer_fixed_point})
	list(APPEND audio_processing_source
		"ns/include/noise_suppression_x.h"
		"ns/noise_suppression_x.c"
		"ns/nsx_core.c"
		"ns/nsx_core.h"
		"ns/nsx_defines.h")
else()
	list(APPEND audio_processing_source
		"ns/defines.h"
		"ns/include/noise_suppression.h"
		"ns/noise_suppression.c"
		"ns/ns_core.c"
		"ns/ns_core.h"
		"ns/windows_private.h")
endif()
if (${target_arch} STREQUAL "mipsel")
	list(APPEND audio_processing_source
		"aecm/aecm_core_mips.c")
else()
	list(APPEND audio_processing_source
		"aecm/aecm_core_c.c")
endif()
add_library(audio_processing STATIC ${audio_processing_source})
target_link_libraries(audio_processing common_audio)
target_link_libraries(audio_processing system_wrappers)
if (${aec_debug_dump})
	target_compile_definitions(audio_processing PRIVATE "WEBRTC_AEC_DEBUG_DUMP")
endif()
if (${aec_untrusted_delay_for_testing})
	target_compile_definitions(audio_processing PRIVATE "WEBRTC_UNTRUSTED_DELAY")
endif()
if (${enable_protobuf})
	PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS "debug.proto")
	add_library(audioproc_debug_proto STATIC ${PROTO_SRCS} ${PROTO_HDRS})
	# PROTOBUF_GENERATE_CPP默认生成的文件放在build目录下，
	# 复制出来便于其他项目文件引用
	add_custom_command(TARGET audioproc_debug_proto POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy ${PROTO_HDRS} "${CMAKE_CURRENT_SOURCE_DIR}/debug.pb.h")
	target_link_libraries(audioproc_debug_proto ${PROTOBUF_LIBRARIES})
	target_include_directories(audioproc_debug_proto
		PUBLIC "${PROTOBUF_INCLUDE_DIRS}")
	target_link_libraries(audio_processing audioproc_debug_proto)
	target_compile_definitions(audio_processing PRIVATE "WEBRTC_AUDIOPROC_DEBUG_DUMP")
endif()
if (${prefer_fixed_point})
	target_compile_definitions(audio_processing PRIVATE "WEBRTC_NS_FIXED")
else()
	target_compile_definitions(audio_processing PRIVATE "WEBRTC_NS_FLOAT")
endif()
if (${target_arch} STREQUAL "x64"  OR  ${target_arch} STREQUAL "ia32")
	add_library(audio_processing_sse2 STATIC "aec/aec_core_sse2.c" "aec/aec_rdft_sse2.c")
	if(MSVC)
		message (STATUS "enable audio_processing_sse2 in Visual Studio!")
		target_compile_options(audio_processing_sse2 PRIVATE "/arch:SSE2")
		target_compile_options(audio_processing_sse2 PRIVATE "/wd4334" PRIVATE "/wd4334")
	elseif(${CMAKE_COMPILER_IS_GNUCXX})
		message (STATUS "enable audio_processing_sse2 in gcc!")
		target_compile_options(audio_processing_sse2 PRIVATE "-msse2")
	endif()
	target_link_libraries(audio_processing audio_processing_sse2)
endif()
