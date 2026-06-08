project(vpklib)

set(VPKLIB_SOURCES
	${SRC_DIR}/common/simplebitstring.cpp
	packedstore.cpp
)

set(VPKLIB_HEADERS
	#${SRC_DIR}/common/crypto.h
	${SRC_DIR}/common/simplebitstring.h
	${SRC_DIR}/public/vpklib/packedstore.h
	packedstore_internal.h
)

source_group("Source Files" FILES ${VPKLIB_SOURCES})
source_group("Header Files" FILES ${VPKLIB_HEADERS})

add_public_library(vpklib ${VPKLIB_SOURCES} ${VPKLIB_HEADERS})

target_include_directories(vpklib PRIVATE
	${SRCDIR}/common
	${SRCDIR}/public
	${SRCDIR}/public/tier0
	${SRCDIR}/public/tier1
)