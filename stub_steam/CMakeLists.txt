project(steam_api)

set(STEAM_API_SOURCES
	steam_api.cpp
)

source_group("Source Files" FILES ${STEAM_API_SOURCES})

add_public_library(steam_api ${STEAM_API_SOURCES})

target_include_directories(steam_api PRIVATE
	${SRC_DIR}/public
	${SRC_DIR}/public/tier0
)