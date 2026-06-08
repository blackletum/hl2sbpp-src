project(choreoobjects)

set(CHOREOOBJECTS_SOURCES
	${SRC_DIR}/game/shared/choreoactor.cpp
	${SRC_DIR}/game/shared/choreochannel.cpp
	${SRC_DIR}/game/shared/choreoevent.cpp
	${SRC_DIR}/game/shared/choreoscene.cpp
	${SRC_DIR}/game/shared/sceneimage.cpp
)

set(CHOREOOBJECTS_HEADERS
	${SRC_DIR}/game/shared/choreoactor.h
	${SRC_DIR}/game/shared/choreochannel.h
	${SRC_DIR}/game/shared/choreoevent.h
	${SRC_DIR}/game/shared/choreoscene.h
	${SRC_DIR}/public/mathlib/mathlib.h
	${SRC_DIR}/game/shared/sceneimage.h
	${SRC_DIR}/public/mathlib/vector.h
	${SRC_DIR}/public/mathlib/vector2d.h
)

source_group("Source Files" FILES ${CHOREOOBJECTS_SOURCES})
source_group("Header Files" FILES ${CHOREOOBJECTS_HEADERS})

add_public_library(choreoobjects ${CHOREOOBJECTS_SOURCES} ${CHOREOOBJECTS_HEADERS})

target_include_directories(choreoobjects PRIVATE
	${SRC_DIR}/common
	${SRC_DIR}/game/shared
	${SRC_DIR}/utils/common
	${SRC_DIR}/public
	${SRC_DIR}/public/tier0
	${SRC_DIR}/public/tier1
)