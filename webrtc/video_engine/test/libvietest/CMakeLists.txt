include_directories("${webrtc_root}/")

set (libvietest_source
        # Helper classes
        "include/vie_external_render_filter.h"
        "include/vie_fake_camera.h"
        "include/vie_file_capture_device.h"
        "include/vie_to_file_renderer.h"

        "helpers/vie_fake_camera.cc"
        "helpers/vie_file_capture_device.cc"
        "helpers/vie_to_file_renderer.cc"

        # Testbed classes
        "include/tb_capture_device.h"
        "include/tb_external_transport.h"
        "include/tb_I420_codec.h"
        "include/tb_interfaces.h"
        "include/tb_video_channel.h"

        "testbed/tb_capture_device.cc"
        "testbed/tb_external_transport.cc"
        "testbed/tb_I420_codec.cc"
        "testbed/tb_interfaces.cc"
        "testbed/tb_video_channel.cc")


add_library(libvietest STATIC ${libvietest_source})
target_link_libraries(libvietest system_wrappers
								gtest
								test_support
								video_engine_core)
if (MSVC)
	target_compile_options(libvietest PRIVATE "/wd4267")
endif()
