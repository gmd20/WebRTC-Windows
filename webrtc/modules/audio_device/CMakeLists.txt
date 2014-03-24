include_directories("./"
	                "../interface"
					"include"
					"dummy"
					"${webrtc_root}/webrtc")

set (audio_device_source
        "include/audio_device.h"
        "include/audio_device_defines.h"
        "audio_device_buffer.cc"
        "audio_device_buffer.h"
        "audio_device_generic.cc"
        "audio_device_generic.h"
        "audio_device_utility.cc"
        "audio_device_utility.h"
        "audio_device_impl.cc"
        "audio_device_impl.h"
        "audio_device_config.h"
        "dummy/audio_device_dummy.cc"
        "dummy/audio_device_dummy.h"
        "dummy/audio_device_utility_dummy.cc"
        "dummy/audio_device_utility_dummy.h")

if (${include_internal_audio_device})
	if (MSVC)
		list(APPEND audio_device_source
			"win/audio_device_core_win.cc"
			"win/audio_device_core_win.h"
			"win/audio_device_wave_win.cc"
			"win/audio_device_wave_win.h"
			"win/audio_device_utility_win.cc"
			"win/audio_device_utility_win.h"
			"win/audio_mixer_manager_win.cc"
			"win/audio_mixer_manager_win.h")
	else(UNIX)
		list(APPEND audio_device_source
			"linux/alsasymboltable_linux.cc"
			"linux/alsasymboltable_linux.h"
			"linux/audio_device_alsa_linux.cc"
			"linux/audio_device_alsa_linux.h"
			"linux/audio_device_utility_linux.cc"
			"linux/audio_device_utility_linux.h"
			"linux/audio_mixer_manager_alsa_linux.cc"
			"linux/audio_mixer_manager_alsa_linux.h"
			"linux/latebindingsymboltable_linux.cc"
			"linux/latebindingsymboltable_linux.h")
		if(${include_pulse_audio})
			list(APPEND audio_device_source
				"linux/audio_device_pulse_linux.cc"
				"linux/audio_device_pulse_linux.h"
				"linux/audio_mixer_manager_pulse_linux.cc"
				"linux/audio_mixer_manager_pulse_linux.h"
				"linux/pulseaudiosymboltable_linux.cc"
				"linux/pulseaudiosymboltable_linux.h")
		endif()
	endif()
endif()

add_library(audio_device STATIC ${audio_device_source})
target_link_libraries(audio_device webrtc_utility)
target_link_libraries(audio_device common_audio)
target_link_libraries(audio_device system_wrappers)
if(MSVC)
	target_include_directories(audio_device
		PRIVATE "win")
elseif(UNIX)
	target_include_directories(audio_device
		PRIVATE "linux")
endif()
if (${include_internal_audio_device})
	if (MSVC)
		# Required for the built-in WASAPI AEC.
		target_link_libraries(audio_device dmoguids)
		target_link_libraries(audio_device wmcodecdspuuid)
		target_link_libraries(audio_device amstrmid)
		target_link_libraries(audio_device msdmo)
	elseif(UNIX)
		target_link_libraries(audio_device dl)
		target_link_libraries(audio_device X11)
		if(${include_pulse_audio})
			target_compile_definitions(audio_device PRIVATE "LINUX_PULSE")
		endif()
	endif()
else()
	target_include_directories(audio_device
		PRIVATE "WEBRTC_DUMMY_AUDIO_BUILD")
endif()


if (${include_tests})
	set (audio_device_tests_source
		"test/audio_device_test_api.cc"
		"test/audio_device_test_defines.h")
	add_executable(audio_device_tests ${audio_device_tests_source})
	target_link_libraries(audio_device_tests audio_device)
	target_link_libraries(audio_device_tests webrtc_utility)
	target_link_libraries(audio_device_tests test_support_main)
	target_link_libraries(audio_device_tests gtest)
	target_link_libraries(audio_device_tests system_wrappers)
	target_include_directories(audio_device_tests
		PRIVATE "${webrtc_root}/third_party/testing/gtest/include"
		PRIVATE "${webrtc_root}/third_party")

	set (audio_device_test_func_source
		"test/audio_device_test_func.cc"
		"test/audio_device_test_defines.h"
		"test/func_test_manager.cc"
		"test/func_test_manager.h")
	add_executable(audio_device_test_func ${audio_device_test_func_source})
	target_link_libraries(audio_device_test_func audio_device)
	target_link_libraries(audio_device_test_func webrtc_utility)
	target_link_libraries(audio_device_test_func common_audio)
	target_link_libraries(audio_device_test_func system_wrappers)
	target_link_libraries(audio_device_test_func test_support)
	target_link_libraries(audio_device_test_func gtest)
	target_include_directories(audio_device_test_func
		PRIVATE "${webrtc_root}/third_party/testing/gtest/include"
		PRIVATE "${webrtc_root}/third_party")
endif()
