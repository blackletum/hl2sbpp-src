project(dmxloader)

set(DMXLOADER_SOURCES
	dmxattribute.cpp
	dmxelement.cpp
	dmxloader.cpp
	dmxloadertext.cpp
	dmxserializationdictionary.cpp
)

set(DMXLOADER_HEADERS
	${SRC_DIR}/public/dmxloader/dmxattribute.h
	${SRC_DIR}/public/dmxloader/dmxelement.h
	${SRC_DIR}/public/dmxloader/dmxloader.h
	dmxserializationdictionary.h
)

source_group("Source Files" FILES ${DMXLOADER_SOURCES})
source_group("Header Files" FILES ${DMXLOADER_HEADERS})

add_public_library(dmxloader ${DMXLOADER_SOURCES} ${DMXLOADER_HEADERS})

target_compile_definitions(dmxloader PRIVATE
	DMXLOADER_LIB=1
)

target_include_directories(dmxloader PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}
	${SRC_DIR}/common
	${SRC_DIR}/public
	${SRC_DIR}/public/tier0
	${SRC_DIR}/public/tier1
)