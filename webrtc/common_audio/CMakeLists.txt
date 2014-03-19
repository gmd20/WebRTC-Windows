include_directories("resampler/include"
					"signal_processing/include"
					"vad/include")


set (common_audio_source
        "audio_util.cc"
        "include/audio_util.h"
        "resampler/include/push_resampler.h"
        "resampler/include/resampler.h"
        "resampler/push_resampler.cc"
        "resampler/push_sinc_resampler.cc"
        "resampler/push_sinc_resampler.h"
        "resampler/resampler.cc"
        "resampler/sinc_resampler.cc"
        "resampler/sinc_resampler.h"
        "signal_processing/include/real_fft.h"
        "signal_processing/include/signal_processing_library.h"
        "signal_processing/include/spl_inl.h"
        "signal_processing/auto_corr_to_refl_coef.c"
        "signal_processing/auto_correlation.c"
        "signal_processing/complex_fft.c"
        "signal_processing/complex_fft_tables.h"
        "signal_processing/complex_bit_reverse.c"
        "signal_processing/copy_set_operations.c"
        "signal_processing/cross_correlation.c"
        "signal_processing/division_operations.c"
        "signal_processing/dot_product_with_scale.c"
        "signal_processing/downsample_fast.c"
        "signal_processing/energy.c"
        "signal_processing/filter_ar.c"
        "signal_processing/filter_ar_fast_q12.c"
        "signal_processing/filter_ma_fast_q12.c"
        "signal_processing/get_hanning_window.c"
        "signal_processing/get_scaling_square.c"
        "signal_processing/ilbc_specific_functions.c"
        "signal_processing/levinson_durbin.c"
        "signal_processing/lpc_to_refl_coef.c"
        "signal_processing/min_max_operations.c"
        "signal_processing/randomization_functions.c"
        "signal_processing/refl_coef_to_lpc.c"
        "signal_processing/real_fft.c"
        "signal_processing/resample.c"
        "signal_processing/resample_48khz.c"
        "signal_processing/resample_by_2.c"
        "signal_processing/resample_by_2_internal.c"
        "signal_processing/resample_by_2_internal.h"
        "signal_processing/resample_fractional.c"
        "signal_processing/spl_init.c"
        "signal_processing/spl_sqrt.c"
        "signal_processing/spl_sqrt_floor.c"
        "signal_processing/spl_version.c"
        "signal_processing/splitting_filter.c"
        "signal_processing/sqrt_of_one_minus_x_squared.c"
        "signal_processing/vector_scaling_operations.c"
        "vad/include/webrtc_vad.h"
        "vad/webrtc_vad.c"
        "vad/vad_core.c"
        "vad/vad_core.h"
        "vad/vad_filterbank.c"
        "vad/vad_filterbank.h"
        "vad/vad_gmm.c"
        "vad/vad_gmm.h"
        "vad/vad_sp.c"
        "vad/vad_sp.h")



add_library(common_audio STATIC ${common_audio_source})
target_link_libraries(common_audio system_wrappers)

if (${target_arch} STREQUAL "x64"  OR  ${target_arch} STREQUAL "ia32")
	add_library(common_audio_sse2 STATIC "resampler/sinc_resampler_sse.cc")
	target_link_libraries(common_audio common_audio_sse2)
	if(MSVC)
		message (STATUS "enable common_audio_sse2 in Visual Studio!")
		target_compile_options(common_audio_sse2 PRIVATE "/arch:SSE2")
		target_compile_options(common_audio_sse2 PRIVATE "/wd4334" PRIVATE "/wd4334")
	elseif(${CMAKE_COMPILER_IS_GNUCXX})
		message (STATUS "enable common_audio_sse2 in gcc!")
		target_compile_options(common_audio_sse2 PRIVATE "-msse2")
	endif()
endif()

if(MSVC)
	target_compile_options(common_audio PRIVATE "/wd4334" PRIVATE "/wd4334")
endif()


