include_directories("${webrtc_root}/")

set (command_line_parser_source
	"simple_command_line_parser.h"
	"simple_command_line_parser.cc")

add_library(command_line_parser STATIC ${command_line_parser_source})
