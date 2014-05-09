
set (libtest_source
	# Helper classes
	"include/bit_flip_encryption.h"
	"include/random_encryption.h"
	"helpers/bit_flip_encryption.cc"
	"helpers/random_encryption.cc")

add_library(libtest STATIC ${libtest_source})

