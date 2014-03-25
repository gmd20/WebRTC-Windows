include_directories("${webrtc_root}/")


#remote_bitrate_estimator_components
set (rbe_components_source
        "overuse_detector.cc"
        "overuse_detector.h"
        "remote_bitrate_estimator_single_stream.cc"
        "remote_rate_control.cc"
        "remote_rate_control.h")
add_library(rbe_components STATIC ${rbe_components_source})



set (remote_bitrate_estimator_source
        "include/bwe_defines.h"
        "include/remote_bitrate_estimator.h"
        "include/rtp_to_ntp.h"
        "rate_statistics.cc"
        "rate_statistics.h"
        "rtp_to_ntp.cc")
add_library(remote_bitrate_estimator STATIC ${remote_bitrate_estimator_source})
target_link_libraries(remote_bitrate_estimator system_wrappers)
target_link_libraries(remote_bitrate_estimator rbe_components)
