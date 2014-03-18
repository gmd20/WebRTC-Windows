include_directories("interface"
	"${webrtc_root}"
	"${webrtc_root}/common_audio/signal_processing/include"
	"../codecs/cng/include")


set (NetEq4_source
	"interface/audio_decoder.h"
	"interface/neteq.h"
	"accelerate.cc"
	"accelerate.h"
	"audio_decoder_impl.cc"
	"audio_decoder_impl.h"
	"audio_decoder.cc"
	"audio_multi_vector.cc"
	"audio_multi_vector.h"
	"audio_vector.cc"
	"audio_vector.h"
	"background_noise.cc"
	"background_noise.h"
	"buffer_level_filter.cc"
	"buffer_level_filter.h"
	"comfort_noise.cc"
	"comfort_noise.h"
	"decision_logic.cc"
	"decision_logic.h"
	"decision_logic_fax.cc"
	"decision_logic_fax.h"
	"decision_logic_normal.cc"
	"decision_logic_normal.h"
	"decoder_database.cc"
	"decoder_database.h"
	"defines.h"
	"delay_manager.cc"
	"delay_manager.h"
	"delay_peak_detector.cc"
	"delay_peak_detector.h"
	"dsp_helper.cc"
	"dsp_helper.h"
	"dtmf_buffer.cc"
	"dtmf_buffer.h"
	"dtmf_tone_generator.cc"
	"dtmf_tone_generator.h"
	"expand.cc"
	"expand.h"
	"merge.cc"
	"merge.h"
	"neteq_impl.cc"
	"neteq_impl.h"
	"neteq.cc"
	"statistics_calculator.cc"
	"statistics_calculator.h"
	"normal.cc"
	"normal.h"
	"packet_buffer.cc"
	"packet_buffer.h"
	"payload_splitter.cc"
	"payload_splitter.h"
	"post_decode_vad.cc"
	"post_decode_vad.h"
	"preemptive_expand.cc"
	"preemptive_expand.h"
	"random_vector.cc"
	"random_vector.h"
	"rtcp.cc"
	"rtcp.h"
	"sync_buffer.cc"
	"sync_buffer.h"
	"timestamp_scaler.cc"
	"timestamp_scaler.h"
	"time_stretch.cc"
	"time_stretch.h")

add_library(NetEq4 STATIC ${NetEq4_source})
target_link_libraries(NetEq4 G711)
target_link_libraries(NetEq4 G722)
target_link_libraries(NetEq4 PCM16B)
target_link_libraries(NetEq4 iLBC)
target_link_libraries(NetEq4 iSAC)
target_link_libraries(NetEq4 iSACFix)
target_link_libraries(NetEq4 CNG)
target_link_libraries(NetEq4 common_audio)
target_link_libraries(NetEq4 system_wrappers)
if (${include_opus})
	target_compile_definitions(NetEq4 PRIVATE "WEBRTC_CODEC_OPUS")
	target_link_libraries(NetEq4 webrtc_opus)
endif()


if (${include_tests})
	include("neteq_tests.cmake")

	set (audio_decoder_unittests_source
		"audio_decoder_impl.cc"
		"audio_decoder_impl.h"
		"audio_decoder_unittest.cc"
		"audio_decoder.cc"
		"interface/audio_decoder.h")
	add_library(audio_decoder_unittests STATIC ${audio_decoder_unittests_source})
	target_link_libraries(audio_decoder_unittests G711)
	target_link_libraries(audio_decoder_unittests G722)
	target_link_libraries(audio_decoder_unittests PCM16B)
	target_link_libraries(audio_decoder_unittests iLBC)
	target_link_libraries(audio_decoder_unittests iSAC)
	target_link_libraries(audio_decoder_unittests iSACFix)
	target_link_libraries(audio_decoder_unittests CNG)
	target_link_libraries(audio_decoder_unittests common_audio)
	target_link_libraries(audio_decoder_unittests system_wrappers)
	target_link_libraries(audio_decoder_unittests gtest)
	target_link_libraries(audio_decoder_unittests test_support_main)
	if (${include_opus})
		target_compile_definitions(audio_decoder_unittests PRIVATE "WEBRTC_CODEC_OPUS")
		target_link_libraries(audio_decoder_unittests webrtc_opus)
	endif()
	target_compile_definitions(audio_decoder_unittests
		PRIVATE "AUDIO_DECODER_UNITTEST"
		PRIVATE "WEBRTC_CODEC_G722"
		PRIVATE "WEBRTC_CODEC_ILBC"
		PRIVATE "WEBRTC_CODEC_ISACFX"
		PRIVATE "WEBRTC_CODEC_ISAC"
		PRIVATE "WEBRTC_CODEC_PCM16")
	target_include_directories(audio_decoder_unittests
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
		target_include_directories(audio_decoder_unittests PRIVATE "${webrtc_root}/../third_party/gflags/src/windows")
	else()
		target_include_directories(audio_decoder_unittests PRIVATE "${webrtc_root}/../third_party/gflags/src")
	endif()



	set (neteq_unittest_tools_source
		"tools/audio_loop.cc"
		"tools/audio_loop.h"
		"tools/input_audio_file.cc"
		"tools/input_audio_file.h"
		"tools/neteq_performance_test.cc"
		"tools/neteq_performance_test.h"
		"tools/rtp_generator.cc"
		"tools/rtp_generator.h")
	add_library(neteq_unittest_tools STATIC  ${neteq_unittest_tools_source})
	target_link_libraries(neteq_unittest_tools PCM16B)
	target_link_libraries(neteq_unittest_tools gtest)
	target_link_libraries(neteq_unittest_tools gmock)
	target_include_directories(neteq_unittest_tools
		PRIVATE "tools"
		PRIVATE "${webrtc_root}/../third_party/testing/gtest/include"
		PRIVATE "${webrtc_root}/../third_party/testing/gmock/include")
endif()
