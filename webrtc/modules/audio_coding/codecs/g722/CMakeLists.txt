include_directories("include"
                	"${webrtc_root}"
					"${webrtc_root}/common_audio/signal_processing/include")

set (G722_source
        "include/g722_interface.h"
		"g722_interface.c"
        "g722_encode.c"
        "g722_decode.c"
        "g722_enc_dec.h")

add_library(G722 STATIC ${G722_source})

if (${include_tests}) 
	add_executable(G722Test "test/testG722.cc")
	target_link_libraries(G722Test G722)
endif ()
