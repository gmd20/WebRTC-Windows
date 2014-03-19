include_directories("../interface"
					"../../../interface"
					"${webrtc_root}"
					"${webrtc_root}/webrtc")

add_subdirectory(../acm2 acm2)

set (audio_coding_module_source
       "../interface/audio_coding_module.h"
        "../interface/audio_coding_module_typedefs.h"
        "acm_amr.cc"
        "acm_amr.h"
        "acm_amrwb.cc"
        "acm_amrwb.h"
        "acm_celt.cc"
        "acm_celt.h"
        "acm_cng.cc"
        "acm_cng.h"
        "acm_codec_database.cc"
        "acm_codec_database.h"
        "acm_dtmf_detection.cc"
        "acm_dtmf_detection.h"
        "acm_dtmf_playout.cc"
        "acm_dtmf_playout.h"
        "acm_g722.cc"
        "acm_g722.h"
        "acm_g7221.cc"
        "acm_g7221.h"
        "acm_g7221c.cc"
        "acm_g7221c.h"
        "acm_g729.cc"
        "acm_g729.h"
        "acm_g7291.cc"
        "acm_g7291.h"
        "acm_generic_codec.cc"
        "acm_generic_codec.h"
        "acm_gsmfr.cc"
        "acm_gsmfr.h"
        "acm_ilbc.cc"
        "acm_ilbc.h"
        "acm_isac.cc"
        "acm_isac.h"
        "acm_isac_macros.h"
        "acm_neteq.cc"
        "acm_neteq.h"
        "acm_opus.cc"
        "acm_opus.h"
        "acm_speex.cc"
        "acm_speex.h"
        "acm_pcm16b.cc"
        "acm_pcm16b.h"
        "acm_pcma.cc"
        "acm_pcma.h"
        "acm_pcmu.cc"
        "acm_pcmu.h"
        "acm_red.cc"
        "acm_red.h"
        "acm_resampler.cc"
        "acm_resampler.h"
        "audio_coding_module_impl.cc"
        "audio_coding_module_impl.h")

add_library(audio_coding_module STATIC ${audio_coding_module_source})
target_link_libraries(audio_coding_module acm2)
target_link_libraries(audio_coding_module CNG)
target_link_libraries(audio_coding_module G711)
target_link_libraries(audio_coding_module G722)
target_link_libraries(audio_coding_module iLBC)
target_link_libraries(audio_coding_module iSAC)
target_link_libraries(audio_coding_module iSACFix)
target_link_libraries(audio_coding_module PCM16B)
target_link_libraries(audio_coding_module NetEq)
target_link_libraries(audio_coding_module common_audio)
target_link_libraries(audio_coding_module system_wrappers)
if (${include_opus})
	target_compile_definitions(audio_coding_module PRIVATE "WEBRTC_CODEC_OPUS")
	target_link_libraries(audio_coding_module webrtc_opus)
endif()
target_include_directories(audio_coding_module
	PRIVATE "../codecs/isac/main/interface"
	PRIVATE  "../codecs/ilbc/interface"
	PRIVATE  "../codecs/pcm16b/include"
	PRIVATE "../codecs/g722/include"
	PRIVATE "../codecs/g711/include")



if (${include_tests})
	set (delay_test_source
		"../test/delay_test.cc"
		"../test/Channel.cc"
		"../test/PCMFile.cc"
		"../test/utility.cc")

	add_executable(delay_test ${delay_test_source})
	target_link_libraries(delay_test audio_coding_module)
	target_link_libraries(delay_test gtest)
	target_link_libraries(delay_test test_support)
	target_link_libraries(delay_test gflags)
	target_link_libraries(delay_test system_wrappers)
	target_include_directories(delay_test
		PRIVATE "${webrtc_root}/third_party"
		PRIVATE "${webrtc_root}/third_party/testing/gtest/include"
		PRIVATE "${webrtc_root}/third_party/testing/gmock/include")




	set (insert_packet_with_timing_source
		"../test/insert_packet_with_timing.cc"
		"../test/Channel.cc"
		"../test/PCMFile.cc")

	add_executable(insert_packet_with_timing ${insert_packet_with_timing_source})
	target_link_libraries(insert_packet_with_timing audio_coding_module)
	target_link_libraries(insert_packet_with_timing gtest)
	target_link_libraries(insert_packet_with_timing test_support)
	target_link_libraries(insert_packet_with_timing gflags)
	target_link_libraries(insert_packet_with_timing system_wrappers)
	target_include_directories(insert_packet_with_timing
		PRIVATE "${webrtc_root}/third_party"
		PRIVATE "${webrtc_root}/third_party/testing/gtest/include"
		PRIVATE "${webrtc_root}/third_party/testing/gmock/include")
endif()
