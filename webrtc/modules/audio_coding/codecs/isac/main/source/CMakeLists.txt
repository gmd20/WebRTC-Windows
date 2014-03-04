include_directories("../interface"
                	"${webrtc_root}"
					"${webrtc_root}/common_audio/signal_processing/include")

set (iSAC_source
         "../interface/isac.h"
        "arith_routines.c"
        "arith_routines_hist.c"
        "arith_routines_logist.c"
        "bandwidth_estimator.c"
        "crc.c"
        "decode.c"
        "decode_bwe.c"
        "encode.c"
        "encode_lpc_swb.c"
        "entropy_coding.c"
        "fft.c"
        "filter_functions.c"
        "filterbank_tables.c"
        "intialize.c"
        "isac.c"
        "filterbanks.c"
        "pitch_lag_tables.c"
        "lattice.c"
        "lpc_gain_swb_tables.c"
        "lpc_analysis.c"
        "lpc_shape_swb12_tables.c"
        "lpc_shape_swb16_tables.c"
        "lpc_tables.c"
        "pitch_estimator.c"
        "pitch_filter.c"
        "pitch_gain_tables.c"
        "spectrum_ar_model_tables.c"
        "transform.c"
        "arith_routines.h"
        "bandwidth_estimator.h"
        "codec.h"
        "crc.h"
        "encode_lpc_swb.h"
        "entropy_coding.h")

add_library(iSAC STATIC ${iSAC_source})
target_link_libraries(iSAC common_audio)

if (UNIX) 
	target_link_libraries(iSAC m)
endif ()
