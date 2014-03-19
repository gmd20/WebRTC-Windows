set (neteq_rtpplay_source
	"tools/neteq_rtpplay.cc")
add_executable(neteq_rtpplay  ${neteq_rtpplay_source})
target_link_libraries(neteq_rtpplay NetEq4)
target_link_libraries(neteq_rtpplay NetEq4TestTools)
target_link_libraries(neteq_rtpplay test_support_main)
target_link_libraries(neteq_rtpplay gflags)
if(MSVC)
	target_include_directories(neteq_rtpplay PRIVATE "${webrtc_root}/third_party/gflags/src/windows")
	target_include_directories(neteq_rtpplay PRIVATE "${webrtc_root}/third_party/gflags/src")
else()
	target_include_directories(neteq_rtpplay PRIVATE "${webrtc_root}/third_party/gflags/src")
endif()
# These macros exist so flags and symbols are properly
# exported when building DLLs. Since we don't build DLLs, we
# need to disable them.
target_compile_definitions(neteq_rtpplay
	PRIVATE "GFLAGS_DLL_DECL="
	PRIVATE "GFLAGS_DLL_DECLARE_FLAG="
	PRIVATE "GFLAGS_DLL_DEFINE_FLAG=")



set (RTPencode_source
	"test/RTPencode.cc")
add_executable(RTPencode  ${RTPencode_source})
target_link_libraries(RTPencode NetEq4TestTools)
target_link_libraries(RTPencode G711)
target_link_libraries(RTPencode G722)
target_link_libraries(RTPencode PCM16B)
target_link_libraries(RTPencode iLBC)
target_link_libraries(RTPencode iSAC)
target_link_libraries(RTPencode CNG)
target_link_libraries(RTPencode common_audio)
target_compile_definitions(RTPencode
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
target_include_directories(RTPencode
	PRIVATE "interface"
	PRIVATE "test"
	PRIVATE "${webrtc_root}/webrtc"
	PRIVATE "${webrtc_root}/third_party/testing/gtest/include"
	PRIVATE "${webrtc_root}/third_party/testing/gmock/include"
	PRIVATE "${webrtc_root}/webrtc/common_audio/vad/include"
	PRIVATE "../codecs/isac/main/interface"
	PRIVATE "../codecs/ilbc/interface"
	PRIVATE "../codecs/pcm16b/include"
	PRIVATE "../codecs/g722/include"
	PRIVATE "../codecs/g711/include")
target_compile_options(RTPencode PRIVATE "/wd4267")

set (RTPjitter_source
	"test/RTPjitter.cc")
add_executable(RTPjitter  ${RTPjitter_source})
target_link_libraries(RTPjitter gtest)
target_link_libraries(RTPjitter Ws2_32.lib)
target_include_directories(RTPjitter
	PRIVATE "${webrtc_root}/third_party/testing/gtest/include")

set (RTPanalyze_source
	"test/RTPanalyze.cc")
add_executable(RTPanalyze  ${RTPanalyze_source})
target_link_libraries(RTPanalyze NetEq4TestTools)
target_link_libraries(RTPanalyze gtest)


set (RTPchange_source
	"test/RTPchange.cc")
add_executable(RTPchange  ${RTPchange_source})
target_link_libraries(RTPchange NetEq4TestTools)
target_link_libraries(RTPchange gtest)


set (RTPtimeshift_source
	"test/RTPtimeshift.cc")
add_executable(RTPtimeshift  ${RTPtimeshift_source})
target_link_libraries(RTPtimeshift NetEq4TestTools)
target_link_libraries(RTPtimeshift gtest)
target_include_directories(RTPtimeshift
	PRIVATE "${webrtc_root}/third_party/testing/gtest/include")


set (RTPcat_source
	"test/RTPcat.cc")
add_executable(RTPcat  ${RTPcat_source})
target_link_libraries(RTPcat NetEq4TestTools)
target_link_libraries(RTPcat gtest)
target_include_directories(RTPcat
	PRIVATE "${webrtc_root}/third_party/testing/gtest/include")


set (rtp_to_text_source
	"test/rtp_to_text.cc")
add_executable(rtp_to_text  ${rtp_to_text_source})
target_link_libraries(rtp_to_text NetEq4TestTools)
target_link_libraries(rtp_to_text system_wrappers)
target_include_directories(rtp_to_text
	PRIVATE "${webrtc_root}/webrtc/system_wrappers/interface")


set (neteq4_speed_test_source
	"test/neteq_speed_test.cc")
add_executable(neteq4_speed_test  ${neteq4_speed_test_source})
target_link_libraries(neteq4_speed_test NetEq4)
target_link_libraries(neteq4_speed_test neteq_unittest_tools)
target_link_libraries(neteq4_speed_test PCM16B)
target_link_libraries(neteq4_speed_test gflags)
target_link_libraries(neteq4_speed_test test_support_main)
if(MSVC)
	target_include_directories(neteq4_speed_test PRIVATE "${webrtc_root}/third_party/gflags/src/windows")
	target_include_directories(neteq4_speed_test PRIVATE "${webrtc_root}/third_party/gflags/src")
else()
	target_include_directories(neteq4_speed_test PRIVATE "${webrtc_root}/third_party/gflags/src")
endif()
# These macros exist so flags and symbols are properly
# exported when building DLLs. Since we don't build DLLs, we
# need to disable them.
target_compile_definitions(neteq4_speed_test
	PRIVATE "GFLAGS_DLL_DECL="
	PRIVATE "GFLAGS_DLL_DECLARE_FLAG="
	PRIVATE "GFLAGS_DLL_DEFINE_FLAG=")


set (NetEq4TestTools_source
	"test/NETEQTEST_DummyRTPpacket.cc"
	"test/NETEQTEST_DummyRTPpacket.h"
	"test/NETEQTEST_RTPpacket.cc"
	"test/NETEQTEST_RTPpacket.h")
add_library(NetEq4TestTools STATIC  ${NetEq4TestTools_source})
target_link_libraries(NetEq4TestTools G711)
target_link_libraries(NetEq4TestTools G722)
target_link_libraries(NetEq4TestTools PCM16B)
target_link_libraries(NetEq4TestTools iLBC)
target_link_libraries(NetEq4TestTools iSAC)
target_link_libraries(NetEq4TestTools CNG)
target_link_libraries(NetEq4TestTools gtest)
target_link_libraries(NetEq4TestTools Ws2_32.lib)
target_include_directories(NetEq4TestTools
	PRIVATE "interface"
	PRIVATE "test"
	PRIVATE "${webrtc_root}/webrtc"
	PRIVATE "${webrtc_root}/third_party/testing/gtest/include"
	PRIVATE "${webrtc_root}/third_party/testing/gmock/include")
target_compile_options(NetEq4TestTools PRIVATE "/wd4267")
