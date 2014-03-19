if (MSVC)
	set (gflags_source
		"src/gflags.cc"
		"src/gflags_completions.cc"
		"src/gflags_reporting.cc"
		"src/windows/port.cc")
else (UNIX)
	set (gflags_source
		"src/gflags.cc"
		"src/gflags_completions.cc"
		"src/gflags_reporting.cc")
endif()

add_library(gflags STATIC ${gflags_source})
# These macros exist so flags and symbols are properly
# exported when building DLLs. Since we don't build DLLs, we
# need to disable them.
target_compile_definitions(gflags
	PUBLIC "GFLAGS_DLL_DECL="
	PUBLIC "GFLAGS_DLL_DECLARE_FLAG="
	PUBLIC "GFLAGS_DLL_DEFINE_FLAG=")
if (MSVC)
	target_compile_options(gflags PRIVATE "/wd4005" PRIVATE "/wd4267")
	target_include_directories(gflags
		PUBLIC "src/windows"
		PUBLIC "src/windows/gflags"
		PUBLIC "src")
else(UNIX)
	target_include_directories(gflags
		PUBLIC "src/"
		PUBLIC "src/gflags")
endif()
