#
# 这里只是一个以编译好的libvpx的包装。 Windows平台用生成的vpx.sln来编译
#

if (MSVC)
	link_directories("${webrtc_root}/third_party/libvpx/Win32/Release")
	add_library(libvpx STATIC IMPORTED)
	set_property(TARGET libvpx PROPERTY IMPORTED_LOCATION  "${webrtc_root}/third_party/libvpx/Win32/Release/vpxmt.lib")
elseif (UNIX)
	message(FATAL_ERROR "libvpx is not defined on Linux. please manually build it and import is here")
endif ()

set(libvpx_include_dir "${webrtc_root}/third_party/libvpx-v1.3.0")


