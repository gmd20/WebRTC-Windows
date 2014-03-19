include_directories("include"
					"${webrtc_root}/webrtc"
					"${webrtc_root}/webrtc/common_audio/signal_processing/include")

set (G711_source
        "include/g711_interface.h"
		"g711_interface.c"
        "g711.c"
        "g711.h")

add_library(G711 STATIC ${G711_source})

if (${include_tests})
	add_executable(g711_test "test/testG711.cc")
	target_link_libraries(g711_test G711)
endif ()

