project(tier3)

set(TIER3_SOURCES
	tier3.cpp
	mdlutils.cpp
	choreoutils.cpp
	scenetokenprocessor.cpp
	studiohdrstub.cpp
)

set(TIER3_HEADERS
	${SRC_DIR}/public/tier3/tier3.h
	${SRC_DIR}/public/tier3/mdlutils.h
	${SRC_DIR}/public/tier3/choreoutils.h
	${SRC_DIR}/public/tier3/scenetokenprocessor.h
)

source_group("Source Files" FILES ${TIER3_SOURCES})
source_group("Header Files" FILES ${TIER3_HEADERS})

add_public_library(tier3 ${TIER3_SOURCES} ${TIER3_HEADERS})

target_include_directories(tier3 PRIVATE
	${SRC_DIR}/public/tier0
	${SRC_DIR}/public/tier1
	${SRC_DIR}/public/tier2
	${SRC_DIR}/public/tier3
	${SRC_DIR}/public/vstdlib
)

target_link_libraries(tier3 PRIVATE
	tier0
	tier1
	tier2
	vstdlib
)