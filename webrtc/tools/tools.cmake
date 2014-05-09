include_directories("${webrtc_root}/")

set (video_quality_analysis_source
	"frame_analyzer/video_quality_analysis.h"
	"frame_analyzer/video_quality_analysis.cc")
add_library(video_quality_analysis STATIC ${video_quality_analysis_source})
target_link_libraries(video_quality_analysis libyuv)


set (frame_analyzer_source
	"frame_analyzer/frame_analyzer.cc")
add_executable(frame_analyzer  ${frame_analyzer_source})
target_link_libraries(frame_analyzer command_line_parser video_quality_analysis)


set (psnr_ssim_analyzer_source
	"psnr_ssim_analyzer/psnr_ssim_analyzer.cc")
add_executable(psnr_ssim_analyzer ${psnr_ssim_analyzer_source})
target_link_libraries(psnr_ssim_analyzer command_line_parser video_quality_analysis)


set (rgba_to_i420_converter_source
	"converter/converter.h"
	"converter/converter.cc"
	"converter/rgba_to_i420_converter.cc")
add_executable(rgba_to_i420_converter ${rgba_to_i420_converter_source})
target_link_libraries(rgba_to_i420_converter command_line_parser libyuv)


set (frame_editing_lib_source
	"frame_editing/frame_editing_lib.cc"
	"frame_editing/frame_editing_lib.h")
add_library(frame_editing_lib STATIC ${frame_editing_lib_source})
target_link_libraries(frame_editing_lib common_video)
if(MSVC)
	target_compile_options(frame_editing_lib PRIVATE "/wd4267")
endif()


set (frame_editor_source
	"frame_editing/frame_editing.cc")
add_executable(frame_editor ${frame_editor_source})
target_link_libraries(frame_editor command_line_parser frame_editing_lib)


set (force_mic_volume_max_source
	"force_mic_volume_max/force_mic_volume_max.cc")
add_executable(force_mic_volume_max ${force_mic_volume_max_source})
target_link_libraries(force_mic_volume_max voice_engine)



add_custom_target(tools)
add_dependencies(tools video_quality_analysis frame_analyzer  psnr_ssim_analyzer rgba_to_i420_converter frame_editing_lib frame_editor force_mic_volume_max)


if(${include_tests})
	set (audio_e2e_harness_source
		"e2e_quality/audio/audio_e2e_harness.cc")
	add_executable(audio_e2e_harness ${audio_e2e_harness_source})
	target_link_libraries(audio_e2e_harness channel_transport voice_engine gtest gflags)
	target_include_directories(audio_e2e_harness
		PUBLIC "${webrtc_root}/third_party"
		PUBLIC "${webrtc_root}/third_party/testing"
		PUBLIC "${webrtc_root}/third_party/testing/gmock/include"
		PUBLIC "${webrtc_root}/third_party/testing/gtest/include")


	set (tools_unittests_source
		"simple_command_line_parser_unittest.cc"
		"frame_editing/frame_editing_unittest.cc"
		"frame_analyzer/video_quality_analysis_unittest.cc")
	add_executable(tools_unittests ${tools_unittests_source})
	target_link_libraries(tools_unittests frame_editing_lib video_quality_analysis command_line_parser test_support_main gtest)
	if(MSVC)
		 # size_t to int truncation.
		target_compile_options(tools_unittests PRIVATE "/wd4267")
	endif()


	add_dependencies(tools audio_e2e_harness tools_unittests)
endif()
