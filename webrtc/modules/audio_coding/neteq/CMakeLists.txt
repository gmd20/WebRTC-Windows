include_directories("interface"
					"${webrtc_root}"
					"${webrtc_root}/common_audio/signal_processing/include"
					"../codecs/cng/include")


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
target_link_libraries(NetEq CNG)
target_link_libraries(NetEq common_audio)

if (${include_tests})
	set (NetEqTestTools_source
		"test/NETEQTEST_CodecClass.cc"
		"test/NETEQTEST_CodecClass.h"
		"test/NETEQTEST_DummyRTPpacket.cc"
		"test/NETEQTEST_DummyRTPpacket.h"
		"test/NETEQTEST_NetEQClass.cc"
		"test/NETEQTEST_NetEQClass.h"
		"test/NETEQTEST_RTPpacket.cc"
		"test/NETEQTEST_RTPpacket.h")
	add_library(NetEqTestTools STATIC ${NetEqTestTools_source})
	target_link_libraries(NetEqTestTools gflags)
	target_link_libraries(NetEqTestTools G711)
	target_link_libraries(NetEqTestTools G722)
	target_link_libraries(NetEqTestTools PCM16B)
	target_link_libraries(NetEqTestTools iLBC)
	target_link_libraries(NetEqTestTools iSAC)
	target_link_libraries(NetEqTestTools CNG)
	target_link_libraries(NetEqTestTools Ws2_32.lib)
	target_compile_definitions(NetEqTestTools
		PRIVATE "CODEC_ILBC"
		PRIVATE "CODEC_PCM16B"
		PRIVATE "CODEC_G711"
		PRIVATE "CODEC_G722"
		PRIVATE "CODEC_ISAC"
		PRIVATE "CODEC_PCM16B_WB"
		PRIVATE "CODEC_ISAC_SWB"
		PRIVATE "CODEC_ISAC_FB"
		PRIVATE "CODEC_PCM16B_32KHZ"
		PRIVATE "CODEC_CNGCODEC8"
		PRIVATE "CODEC_CNGCODEC16"
		PRIVATE "CODEC_CNGCODEC32"
		PRIVATE "CODEC_ATEVENT_DECODE"
		PRIVATE "CODEC_RED")
	target_include_directories(NetEqTestTools
		PRIVATE "interface"
		PRIVATE "test"
		PRIVATE "../codecs/isac/main/interface"
		PRIVATE "${webrtc_root}/../third_party/testing/gtest/include"
		PRIVATE "${webrtc_root}/../third_party/testing/gmock/include"
		PRIVATE  "../codecs/ilbc/interface"
		PRIVATE  "../codecs/pcm16b/include"
		PRIVATE "../codecs/g722/include"
		PRIVATE "../codecs/g711/include")
	if(MSVC)
		target_compile_options(NetEqTestTools PRIVATE "/wd4267")
		target_compile_definitions(NetEqTestTools PRIVATE "NOMINMAX")
		target_include_directories(NetEqTestTools PRIVATE "${webrtc_root}/../third_party/gflags/src/windows")
	else()
		target_include_directories(NetEqTestTools PRIVATE "${webrtc_root}/../third_party/gflags/src")
	endif()
	# These macros exist so flags and symbols are properly
	# exported when building DLLs. Since we don't build DLLs, we
	# need to disable them.
	target_compile_definitions(NetEqTestTools
		PRIVATE "GFLAGS_DLL_DECL="
		PRIVATE "GFLAGS_DLL_DECLARE_FLAG="
		PRIVATE "GFLAGS_DLL_DEFINE_FLAG=")

	add_executable(neteq_unittests "webrtc_neteq_unittest.cc")
	target_link_libraries(neteq_unittests NetEq)
	target_link_libraries(neteq_unittests neteq_unittest_tools)
	target_link_libraries(neteq_unittests gtest)
	target_link_libraries(neteq_unittests gflags)
	target_link_libraries(neteq_unittests NetEqTestTools)
	target_link_libraries(neteq_unittests test_support_main)
	target_link_libraries(neteq_unittests PCM16B)
	target_link_libraries(neteq_unittests iLBC)
	target_link_libraries(neteq_unittests iSAC)
	target_link_libraries(neteq_unittests CNG)
	target_include_directories(neteq_unittests
		PRIVATE "${webrtc_root}/../third_party/testing/gtest/include"
		PRIVATE "${webrtc_root}/../third_party/testing/gmock/include")
	if (MSVC)
		target_compile_definitions(neteq_unittests PRIVATE "NOMINMAX")
		target_include_directories(neteq_unittests PRIVATE "${webrtc_root}/../third_party/gflags/src/windows")
	else()
		target_include_directories(neteq_unittests PRIVATE "${webrtc_root}/../third_party/gflags/src")
	endif()
	# These macros exist so flags and symbols are properly
	# exported when building DLLs. Since we don't build DLLs, we
	# need to disable them.
	target_compile_definitions(neteq_unittests
		PRIVATE "GFLAGS_DLL_DECL="
		PRIVATE "GFLAGS_DLL_DECLARE_FLAG="
		PRIVATE "GFLAGS_DLL_DEFINE_FLAG=")

	add_executable(NetEqRTPplay "test/NetEqRTPplay.cc")
	target_link_libraries(NetEqRTPplay NetEqTestTools)
	target_link_libraries(NetEqRTPplay NetEq)
	target_link_libraries(NetEqRTPplay G711)
	target_link_libraries(NetEqRTPplay G722)
	target_link_libraries(NetEqRTPplay PCM16B)
	target_link_libraries(NetEqRTPplay iLBC)
	target_link_libraries(NetEqRTPplay iSAC)
	target_link_libraries(NetEqRTPplay CNG)
	target_compile_definitions(NetEqRTPplay
		PRIVATE "CODEC_ILBC"
		PRIVATE "CODEC_PCM16B"
		PRIVATE "CODEC_G711"
		PRIVATE "CODEC_G722"
		PRIVATE "CODEC_ISAC"
		PRIVATE "CODEC_PCM16B_WB"
		PRIVATE "CODEC_ISAC_SWB"
		PRIVATE "CODEC_ISAC_FB"
		PRIVATE "CODEC_PCM16B_32KHZ"
		PRIVATE "CODEC_CNGCODEC8"
		PRIVATE "CODEC_CNGCODEC16"
		PRIVATE "CODEC_CNGCODEC32"
		PRIVATE "CODEC_ATEVENT_DECODE"
		PRIVATE "CODEC_RED")
	target_include_directories(NetEqRTPplay
		PRIVATE "./"
		PRIVATE "test"
		PRIVATE "../codecs/isac/main/interface"
		PRIVATE "../codecs/pcm16b/include"
		PRIVATE "../codecs/g711/include")
	if (MSVC)
		target_compile_options(NetEqRTPplay PRIVATE "/wd4267")
	endif()


	add_executable(neteq3_speed_test "test/neteq_speed_test.cc")
	target_link_libraries(neteq3_speed_test NetEq)
	target_link_libraries(neteq3_speed_test PCM16B)
	target_link_libraries(neteq3_speed_test neteq_unittest_tools)
	target_link_libraries(neteq3_speed_test gflags)
	target_link_libraries(neteq3_speed_test gtest)
	target_link_libraries(neteq3_speed_test test_support_main)
	target_include_directories(neteq3_speed_test
		PRIVATE "${webrtc_root}/../third_party/testing/gtest/include"
		PRIVATE "${webrtc_root}/../third_party/testing/gmock/include")
	if (MSVC)
		target_include_directories(neteq3_speed_test PRIVATE "${webrtc_root}/../third_party/gflags/src/windows")
	else()
		target_include_directories(neteq3_speed_test PRIVATE "${webrtc_root}/../third_party/gflags/src")
	endif()
	# These macros exist so flags and symbols are properly
	# exported when building DLLs. Since we don't build DLLs, we
	# need to disable them.
	target_compile_definitions(neteq3_speed_test
		PRIVATE "GFLAGS_DLL_DECL="
		PRIVATE "GFLAGS_DLL_DECLARE_FLAG="
		PRIVATE "GFLAGS_DLL_DEFINE_FLAG=")
endif()
