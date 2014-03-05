include_directories("interface"
                	"${webrtc_root}")

set (NetEq_source
        "interface/webrtc_neteq.h"
        "interface/webrtc_neteq_help_macros.h"
        "interface/webrtc_neteq_internal.h"
        "accelerate.c"
        "automode.c"
        "automode.h"
        "bgn_update.c"
        "buffer_stats.h"
        "bufstats_decision.c"
        "cng_internal.c"
        "codec_db.c"
        "codec_db.h"
        "codec_db_defines.h"
        "correlator.c"
        "delay_logging.h"
        "dsp.c"
        "dsp.h"
        "dsp_helpfunctions.c"
        "dsp_helpfunctions.h"
        "dtmf_buffer.c"
        "dtmf_buffer.h"
        "dtmf_tonegen.c"
        "dtmf_tonegen.h"
        "expand.c"
        "mcu.h"
        "mcu_address_init.c"
        "mcu_dsp_common.c"
        "mcu_dsp_common.h"
        "mcu_reset.c"
        "merge.c"
        "min_distortion.c"
        "mix_voice_unvoice.c"
        "mute_signal.c"
        "neteq_defines.h"
        "neteq_error_codes.h"
        "neteq_statistics.h"
        "normal.c"
        "packet_buffer.c"
        "packet_buffer.h"
        "peak_detection.c"
        "preemptive_expand.c"
        "random_vector.c"
        "recin.c"
        "recout.c"
        "rtcp.c"
        "rtcp.h"
        "rtp.c"
        "rtp.h"
        "set_fs.c"
        "signal_mcu.c"
        "split_and_insert.c"
        "unmute_signal.c"
        "webrtc_neteq.c")

add_definitions(-DNETEQ_VOICEENGINE_CODECS -DSCRATCH)

add_library(NetEq STATIC ${NetEq_source})
add_dependencies(NetEq CNG)
add_dependencies(NetEq common_audio)

if (${include_tests})
	add_executable(neteq_unittests "webrtc_neteq_unittest.cc")
	target_link_libraries(neteq_unittests NetEq)
	target_link_libraries(neteq_unittests NetEqTestTools)
	target_link_libraries(neteq_unittests neteq_unittest_tools)
	          '<(DEPTH)/testing/gtest.gyp:gtest',
	        '<(webrtc_root)/test/test.gyp:test_support_main',


	add_executable(NetEqRTPplay "test/NetEqRTPplay.cc")
	target_link_libraries(NetEqRTPplay NetEq)
	target_link_libraries(NetEqRTPplay NetEqTestTools)
	target_link_libraries(NetEqRTPplay G711)
	target_link_libraries(NetEqRTPplay G722)
	target_link_libraries(NetEqRTPplay PCM16B)
	target_link_libraries(NetEqRTPplay iLBC)
	target_link_libraries(NetEqRTPplay iSAC)
	target_link_libraries(NetEqRTPplay CNG)
	set_target_properties(NetEqRTPplay PROPERTIES  COMPILE_DEFINITIONS "CODEC_ILBC;CODEC_PCM16B;CODEC_G711;CODEC_G722;CODEC_ISAC;CODEC_PCM16B_WB;CODEC_ISAC_SWB;CODEC_ISAC_FB;CODEC_PCM16B_32KHZ;CODEC_CNGCODEC8;CODEC_CNGCODEC16;CODEC_CNGCODEC32;CODEC_ATEVENT_DECODE;CODEC_RED") 
	set_target_properties(NetEqRTPplay PROPERTIES  INCLUDE_DIRECTORIES "./  test") 
	if (MSVC)
		set_target_properties(NetEqRTPplay PROPERTIES  COMPILE_FLAGS "/wd4267") 
	endif()



	add_executable(neteq3_speed_test "test/neteq_speed_test.cc")
	target_link_libraries(neteq_unittests NetEq)
	target_link_libraries(neteq_unittests PCM16B)
	target_link_libraries(neteq_unittests neteq_unittest_tools)
	add_subdirectory("${webrtc_root}/../third_party/gflags-2.0" gflags)
	target_link_libraries(neteq_unittests gflags)
	       '<(DEPTH)/third_party/gflags/gflags.gyp:gflags',
	       '<(webrtc_root)/test/test.gyp:test_support_main',



	set (NetEqTestTools_source
			"test/NETEQTEST_CodecClass.cc"
            "test/NETEQTEST_CodecClass.h"
            "test/NETEQTEST_DummyRTPpacket.cc"
            "test/NETEQTEST_DummyRTPpacket.h"
            "test/NETEQTEST_NetEQClass.cc"
            "test/NETEQTEST_NetEQClass.h"
            "test/NETEQTEST_RTPpacket.cc"
            "test/NETEQTEST_RTPpacket.h")

	add_executable(NetEqTestTools  "${NetEqTestTools_source}")
	target_link_libraries(NetEqTestTools G711)
	target_link_libraries(NetEqTestTools G722)
	target_link_libraries(NetEqTestTools PCM16B)
	target_link_libraries(NetEqTestTools iLBC)
	target_link_libraries(NetEqTestTools iSAC)
	target_link_libraries(NetEqTestTools CNG)
	# '<(DEPTH)/testing/gtest.gyp:gtest',
	set_target_properties(NetEqTestTools PROPERTIES  COMPILE_DEFINITIONS "CODEC_ILBC;CODEC_PCM16B;CODEC_G711;CODEC_G722;CODEC_ISAC;CODEC_PCM16B_WB;CODEC_ISAC_SWB;CODEC_ISAC_FB;CODEC_PCM16B_32KHZ;CODEC_CNGCODEC8;CODEC_CNGCODEC16;CODEC_CNGCODEC32;CODEC_ATEVENT_DECODE;CODEC_RED") 
	set_target_properties(NetEqTestTools PROPERTIES  INCLUDE_DIRECTORIES "interface  test") 
	if (MSVC)
		set_target_properties(NetEqTestTools PROPERTIES  COMPILE_FLAGS "/wd4267") 
	endif()
endif()
