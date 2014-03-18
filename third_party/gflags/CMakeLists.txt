if (MSVC)
	include_directories("src/windows")
	include_directories("src/windows/gflags")
	set (gflags_source
		"src/gflags.cc"
		"src/gflags_completions.cc"
		"src/gflags_reporting.cc"
		"src/windows/port.cc")
else (UNIX)
	include_directories("src/")
	include_directories("src/gflags")
	set (gflags_source
		"src/gflags.cc"
		"src/gflags_completions.cc"
		"src/gflags_reporting.cc")
endif()
include_directories("src")

add_library(gflags STATIC ${gflags_source})
# These macros exist so flags and symbols are properly
# exported when building DLLs. Since we don't build DLLs, we
# need to disable them.
target_compile_definitions(gflags
	PRIVATE "GFLAGS_DLL_DECL="
	PRIVATE "GFLAGS_DLL_DECLARE_FLAG="
	PRIVATE "GFLAGS_DLL_DEFINE_FLAG=")
if (MSVC)
	target_compile_options(gflags PRIVATE "/wd4005" PRIVATE "/wd4267")
endif()
