include_directories("${webrtc_root}/")

if (${include_tests})
	add_subdirectory("test/libvietest")
	add_subdirectory("test/auto_test")
endif()

