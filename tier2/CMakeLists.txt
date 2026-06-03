project(tier2)

set(TIER2_SOURCES
	beamsegdraw.cpp
	camerautils.cpp
	defaultfilesystem.cpp
	dmconnect.cpp
	fileutils.cpp
	keybindings.cpp
	keyvaluesmacros.cpp
	${SRC_DIR}/public/map_utils.cpp
	${SRC_DIR}/public/materialsystem/MaterialSystemUtil.cpp
	meshutils.cpp
	p4helpers.cpp
	renderutils.cpp
	riff.cpp
	soundutils.cpp
	tier2.cpp
	util_init.cpp
	utlstreambuffer.cpp
	vconfig.cpp
)

set(TIER2_HEADERS
	${SRC_DIR}/public/tier2/beamsegdraw.h
	${SRC_DIR}/public/tier2/camerautils.h
	${SRC_DIR}/public/tier2/fileutils.h
	${SRC_DIR}/public/tier2/keybindings.h
	${SRC_DIR}/public/tier2/keyvaluesmacros.h
	${SRC_DIR}/public/tier2/meshutils.h
	${SRC_DIR}/public/tier2/renderutils.h
	${SRC_DIR}/public/tier2/riff.h
	${SRC_DIR}/public/tier2/soundutils.h
	${SRC_DIR}/public/tier2/tier2.h
	${SRC_DIR}/public/tier2/utlstreambuffer.h
	${SRC_DIR}/public/tier2/vconfig.h
)

add_public_library(tier2
	${TIER2_SOURCES}
	${TIER2_HEADERS}
)

target_include_directories(tier2
	PUBLIC
		${SRC_DIR}/common
		${SRC_DIR}/public
		${SRC_DIR}/public/tier0
		${SRC_DIR}/public/tier1
		${SRC_DIR}/public/tier2
		${SRC_DIR}/tier2
)

target_link_libraries(tier2
	PRIVATE
		tier0
		tier1
)

if(MSVC)
	set_source_files_properties(
		processor_detect.cpp
		PROPERTIES
			COMPILE_OPTIONS "/EHsc"
	)
endif()

source_group("Source Files" FILES ${TIER1_SOURCES})
source_group("Header Files" FILES ${TIER1_HEADERS})
