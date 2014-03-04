include_directories("../interface"
                	"${webrtc_root}"
					"${webrtc_root}/common_audio/signal_processing/include")

set (iSACFix_source
		"../interface/isacfix.h"
        "arith_routines.c"
        "arith_routines_hist.c"
        "arith_routines_logist.c"
        "bandwidth_estimator.c"
        "decode.c"
        "decode_bwe.c"
        "decode_plc.c"
        "encode.c"
        "entropy_coding.c"
        "fft.c"
        "filterbank_tables.c"
        "filterbanks.c"
        "filters.c"
        "initialize.c"
        "isacfix.c"
        "lattice.c"
        "lattice_c.c"
        "lpc_masking_model.c"
        "lpc_tables.c"
        "pitch_estimator.c"
        "pitch_filter.c"
        "pitch_filter_c.c"
        "pitch_gain_tables.c"
        "pitch_lag_tables.c"
        "spectrum_ar_model_tables.c"
        "transform.c"
        "arith_routins.h"
        "bandwidth_estimator.h"
        "codec.h"
        "entropy_coding.h"
        "fft.h"
        "filterbank_tables.h"
        "lpc_masking_model.h"
        "lpc_tables.h"
        "pitch_estimator.h"
        "pitch_gain_tables.h"
        "pitch_lag_tables.h"
        "settings.h"
        "spectrum_ar_model_tables.h"
        "structs.h")

if (NOT MSVC)
	add_definitions(-DWEBRTC_LINUX)
endif()
add_library(iSACFix STATIC ${iSACFix_source})
target_link_libraries(iSACFix common_audio)
target_link_libraries(iSACFix system_wrappers)

