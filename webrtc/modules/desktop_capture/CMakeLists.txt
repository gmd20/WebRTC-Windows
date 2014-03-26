include_directories( "${webrtc_root}/"
					"${webrtc_root}/webrtc")

set (desktop_capture_source
       "desktop_and_cursor_composer.cc"
        "desktop_and_cursor_composer.h"
        "desktop_capture_types.h"
        "desktop_capturer.h"
        "desktop_frame.cc"
        "desktop_frame.h"
        "desktop_frame_win.cc"
        "desktop_frame_win.h"
        "desktop_geometry.cc"
        "desktop_geometry.h"
        "desktop_capture_options.h"
        "desktop_capture_options.cc"
        "desktop_capturer.h"
        "desktop_region.cc"
        "desktop_region.h"
        "differ.cc"
        "differ.h"
        "differ_block.cc"
        "differ_block.h"
        "mac/desktop_configuration.h"
        "mac/desktop_configuration.mm"
        "mac/scoped_pixel_buffer_object.cc"
        "mac/scoped_pixel_buffer_object.h"
        "mouse_cursor.cc"
        "mouse_cursor.h"
        "mouse_cursor_monitor.h"
        "mouse_cursor_monitor_mac.mm"
        "mouse_cursor_monitor_win.cc"
        "mouse_cursor_monitor_x11.cc"
        "mouse_cursor_shape.h"
        "screen_capture_frame_queue.cc"
        "screen_capture_frame_queue.h"
        "screen_capturer.cc"
        "screen_capturer.h"
        "screen_capturer_helper.cc"
        "screen_capturer_helper.h"
        "screen_capturer_mac.mm"
        "screen_capturer_win.cc"
        "screen_capturer_x11.cc"
        "shared_desktop_frame.cc"
        "shared_desktop_frame.h"
        "shared_memory.cc"
        "shared_memory.h"
        "win/cursor.cc"
        "win/cursor.h"
        "win/desktop.cc"
        "win/desktop.h"
        "win/scoped_gdi_object.h"
        "win/scoped_thread_desktop.cc"
        "win/scoped_thread_desktop.h"
        "window_capturer.cc"
        "window_capturer.h"
        "window_capturer_mac.cc"
        "window_capturer_win.cc"
        "window_capturer_x11.cc"
        "x11/shared_x_display.h"
        "x11/shared_x_display.cc"
        "x11/x_error_trap.cc"
        "x11/x_error_trap.h"
        "x11/x_server_pixel_buffer.cc"
        "x11/x_server_pixel_buffer.h")

if((UNIX) AND (NOT ${use_x11}))
	list(APPEND desktop_capture_source
		"mouse_cursor_monitor_null.cc"
		"screen_capturer_null.cc"
		"window_capturer_null.cc")
	exclude_regex_matched_source("x11/|_x11\\." ${desktop_capture_source})
endif()

extract_platform_specific_source(desktop_capture_source)
add_library(desktop_capture STATIC ${desktop_capture_source})
target_link_libraries(desktop_capture system_wrappers)
if (${target_arch} STREQUAL "x64"  OR  ${target_arch} STREQUAL "ia32")
	add_library(desktop_capture_differ_sse2 STATIC "differ_block_sse2.cc" "differ_block_sse2.h")
	target_link_libraries(desktop_capture desktop_capture_differ_sse2)
	if(MSVC)
		message (STATUS "enable desktop_capture_differ_sse2 in Visual Studio!")
		target_compile_options(desktop_capture_differ_sse2 PRIVATE "/arch:SSE2")
	elseif(${CMAKE_COMPILER_IS_GNUCXX})
		message (STATUS "enable desktop_capture_differ_sse2 in gcc!")
		target_compile_options(desktop_capture_differ_sse2 PRIVATE "-msse2")
	endif()
endif()
if(${use_x11})
	target_link_libraries(desktop_capture X11)
	target_link_libraries(desktop_capture Xcomposite)
	target_link_libraries(desktop_capture Xdamage)
	target_link_libraries(desktop_capture Xext)
	target_link_libraries(desktop_capture Xfixes)
	target_link_libraries(desktop_capture Xrender)
endif()
if (MSVC)
	target_compile_options(desktop_capture PRIVATE "/wd4267")
endif()
