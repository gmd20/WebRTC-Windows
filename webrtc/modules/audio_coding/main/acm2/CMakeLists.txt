include_directories("../interface"
					"../../../interface"
					"${webrtc_root}"
					"${webrtc_root}/webrtc")

set (acm2_source
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
        "acm_common_defs.h"
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
        "acm_receiver.cc"
        "acm_receiver.h"
        "acm_resampler.cc"
        "acm_resampler.h"
        "audio_coding_module.cc"
        "audio_coding_module_impl.cc"
        "audio_coding_module_impl.h"
        "call_statistics.cc"
        "call_statistics.h"
        "initial_delay_manager.cc"
        "initial_delay_manager.h"
        "nack.cc"
        "nack.h")

add_library(acm2 STATIC ${acm2_source})
target_link_libraries(acm2 NetEq4)
target_link_libraries(acm2 CNG)
target_link_libraries(acm2 G711)
target_link_libraries(acm2 G722)
target_link_libraries(acm2 iLBC)
target_link_libraries(acm2 iSAC)
target_link_libraries(acm2 iSACFix)
target_link_libraries(acm2 PCM16B)
target_link_libraries(acm2 NetEq)
target_link_libraries(acm2 common_audio)
target_link_libraries(acm2 system_wrappers)
if (${include_opus})
	target_compile_definitions(acm2 PRIVATE "WEBRTC_CODEC_OPUS")
	target_link_libraries(acm2 webrtc_opus)
endif()
target_include_directories(acm2
	PRIVATE "../codecs/isac/main/interface"
	PRIVATE  "../codecs/ilbc/interface"
	PRIVATE  "../codecs/pcm16b/include"
	PRIVATE "../codecs/g722/include"
	PRIVATE "../codecs/g711/include")
