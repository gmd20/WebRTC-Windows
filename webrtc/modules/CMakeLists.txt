add_subdirectory("audio_coding/codecs/cng")
add_subdirectory("audio_coding/codecs/g711")
add_subdirectory("audio_coding/codecs/g722")
add_subdirectory("audio_coding/codecs/ilbc")
add_subdirectory("audio_coding/codecs/isac/main/source")
add_subdirectory("audio_coding/codecs/isac/fix/source")
add_subdirectory("audio_coding/codecs/opus")
add_subdirectory("audio_coding/codecs/pcm16b")
add_subdirectory("audio_coding/main/source")
add_subdirectory("audio_coding/neteq4")
add_subdirectory("audio_coding/neteq")
add_subdirectory("audio_conference_mixer/source")
add_subdirectory("audio_device")
add_subdirectory("audio_processing")
add_subdirectory("bitrate_controller")
add_subdirectory("desktop_capture")
add_subdirectory("media_file/source")
add_subdirectory("pacing")
add_subdirectory("remote_bitrate_estimator")
add_subdirectory("rtp_rtcp/source")
add_subdirectory("utility/source")
add_subdirectory("video_coding/codecs/i420/main/source")
add_subdirectory("video_coding/codecs/vp8")
add_subdirectory("video_coding/utility")
add_subdirectory("video_coding/main/source")
add_subdirectory("video_capture")
#add_subdirectory("video_processing/main/source")
#add_subdirectory("video_render")


if (${include_tests})
	# add_subdirectory("rtp_rtcp/test/testFec/")
		# 'audio_coding/codecs/isac/isac_test.gypi',
        # 'audio_coding/codecs/isac/isacfix_test.gypi',
		add_subdirectory("audio_processing/test")
        # 'rtp_rtcp/test/testFec/test_fec.gypi',
        # 'video_coding/main/source/video_coding_test.gypi',
        # 'video_coding/codecs/test/video_codecs_test_framework.gypi',
        # 'video_coding/codecs/test_framework/test_framework.gypi',
        # 'video_coding/codecs/tools/video_codecs_tools.gypi'
endif ()
