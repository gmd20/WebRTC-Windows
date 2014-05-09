include_directories("${webrtc_root}/")

set (vie_auto_test_source
        "interface/vie_autotest.h"
        "interface/vie_autotest_defines.h"
        "interface/vie_autotest_linux.h"
        "interface/vie_autotest_mac_cocoa.h"
        "interface/vie_autotest_main.h"
        "interface/vie_autotest_window_manager_interface.h"
        "interface/vie_autotest_windows.h"
        "interface/vie_file_based_comparison_tests.h"
        "interface/vie_window_manager_factory.h"
        "interface/vie_window_creator.h"

        # New, fully automated tests
        "automated/legacy_fixture.cc"
        "automated/two_windows_fixture.cc"
        "automated/vie_api_integration_test.cc"
        "automated/vie_extended_integration_test.cc"
        "automated/vie_rtp_fuzz_test.cc"
        "automated/vie_standard_integration_test.cc"
        "automated/vie_video_verification_test.cc"

        # Test primitives
        "primitives/base_primitives.cc"
        "primitives/base_primitives.h"
        "primitives/choice_helpers.cc"
        "primitives/choice_helpers.h"
        "primitives/choice_helpers_unittest.cc"
        "primitives/fake_stdin.h"
        "primitives/fake_stdin.cc"
        "primitives/framedrop_primitives.h"
        "primitives/framedrop_primitives.cc"
        "primitives/framedrop_primitives_unittest.cc"
        "primitives/general_primitives.cc"
        "primitives/general_primitives.h"
        "primitives/input_helpers.cc"
        "primitives/input_helpers.h"
        "primitives/input_helpers_unittest.cc"

        # Platform independent
        "source/vie_autotest.cc"
        "source/vie_autotest_base.cc"
        "source/vie_autotest_capture.cc"
        "source/vie_autotest_codec.cc"
        "source/vie_autotest_encryption.cc"
        "source/vie_autotest_image_process.cc"
        "source/vie_autotest_loopback.cc"
        "source/vie_autotest_main.cc"
        "source/vie_autotest_render.cc"
        "source/vie_autotest_record.cc"
        "source/vie_autotest_rtp_rtcp.cc"
        "source/vie_autotest_custom_call.cc"
        "source/vie_autotest_simulcast.cc"
        "source/vie_file_based_comparison_tests.cc"
        "source/vie_window_creator.cc")

        # Platform dependent
        # Android
		if (${OS} STREQUAL "android")
			list(APPEND vie_auto_test_source
				"source/vie_autotest_android.cc")
		endif()
		# Linux
		if (${OS} STREQUAL "linux")
			list(APPEND vie_auto_test_source
				"source/vie_autotest_linux.cc"
				"source/vie_window_manager_factory_linux.cc")
		endif()
		# Mac
		if (${OS} STREQUAL "mac")
			list(APPEND vie_auto_test_source
				"source/vie_autotest_cocoa_mac.mm"
				"source/vie_window_manager_factory_mac.mm")
		endif()
        # Windows
		if (${OS} STREQUAL "win")
			list(APPEND vie_auto_test_source
				"source/vie_autotest_win.cc"
				"source/vie_window_manager_factory_win.cc")
		endif()


add_executable(vie_auto_test ${vie_auto_test_source})
target_link_libraries(vie_auto_test system_wrappers
										video_render_module
										video_capture_module
										voice_engine
										gtest
										gflags
										metrics
										channel_transport
										test_support
										libtest
										video_engine_core
										libvietest)
if (UNIX)
	target_link_libraries(vie_auto_test Xexr X11)
endif()
if (UNIX)
	target_compile_options(vie_auto_test PRIVATE "/wd4267")
endif()
